//
//  PacketTunnelProvider.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 25.06.2024.
//

import Foundation
import NetworkExtension
import Tun2socks

final class PacketTunnelProvider: NEPacketTunnelProvider {
  private var hostNetworkAddress: String?
  private var tun2socksTunnel: Tun2socksTunnelProtocol?
  private var tunnel: Tunnel?
  private var tunnelStore = TunnelStore(appGroup: "group.ru.apriakhin.ShadowsocksClient")
  private var packetQueue = DispatchQueue(label: "ru.apriakhin.ShadowsocksClient.packetqueue")
  private var startCompletion: ((ErrorCode) -> Void)?
  private var stopCompletion: ((ErrorCode) -> Void)?
  private var defaultPathObserver: NSKeyValueObservation?

  override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
    guard let options, let tunnel = retrieveTunnelConfig(with: options) else {
      execAppCallback(for: .start, errorCode: .illegalServerConfiguration)
      completionHandler(NSError(code: .configurationUnknown))
      return
    }
    
    self.tunnel = tunnel
    
    guard let hostNetworkAddress = getNetworkIpAddress(tunnel.host) else {
      execAppCallback(for: .start, errorCode: .illegalServerConfiguration)
      completionHandler(NSError(code: .configurationReadWriteFailed))
      return
    }
    
    self.hostNetworkAddress = hostNetworkAddress
    
    let isOnDemand = options[MessageKey.onDemand.rawValue] != nil
    var error = 0
    
    if !isOnDemand {
      guard let client = getClient() else {
        execAppCallback(for: .start, errorCode: .illegalServerConfiguration)
        completionHandler(NSError(code: .configurationInvalid))
        return
      }
      
      ShadowsocksCheckConnectivity(client, &error, nil)
    }
    
    let errorCode = ErrorCode(rawValue: error) ?? .undefinedError
    
    if errorCode != .noError && errorCode != .udpRelayNotEnabled {
      execAppCallback(for: .start, errorCode: errorCode)
      completionHandler(NSError(code: .connectionFailed))
      return
    }
    
    let settings = getTunnelNetworkSettings(tunnelRemoteAddress: hostNetworkAddress)
    
    connectTunnel(settings: settings) { error in
      if let error {
        self.execAppCallback(for: .start, errorCode: .vpnPermissionNotGranted)
        completionHandler(error)
        return
      }
      
      let isUdpSupported = isOnDemand ? self.tunnelStore.isUdpSupported : errorCode == .noError
      
      if !self.startTun2Socks(isUdpSupported: isUdpSupported) {
        self.execAppCallback(for: .start, errorCode: .vpnStartFailure)
        completionHandler(NSError(code: .connectionFailed))
        return
      }
      
      self.listenForNetworkChanges()
      self.tunnelStore.save(tunnel)
      self.tunnelStore.isUdpSupported = isUdpSupported
      self.tunnelStore.status = .connected
      self.execAppCallback(for: .start)
      
      completionHandler(nil)
    }
  }
  
  override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
    tunnelStore.status = .disconnected
    defaultPathObserver = nil
    tun2socksTunnel?.disconnect()
    cancelTunnelWithError(nil)
    execAppCallback(for: .stop)
    completionHandler()
  }
  
  override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
    guard let message = try? JSONSerialization.jsonObject(with: messageData, options: []) as? [String: Any],
          let action = Action(by: message) 
    else {
      completionHandler?(nil)
      return
    }
    
    let callbackWrapper: (ErrorCode) -> Void = { [weak self] errorCode in
      let response: [String: Any] = [
        MessageKey.action.rawValue: action.rawValue,
        MessageKey.errorCode.rawValue: errorCode.rawValue,
        MessageKey.id.rawValue: self?.tunnel?.id ?? ""
      ]
      
      let data = try? JSONSerialization.data(withJSONObject: response, options: [])
      
      completionHandler?(data)
    }
    
    switch action {
    case .start:
      startCompletion = callbackWrapper
      
    case .restart:
      startCompletion = callbackWrapper
      tunnel = Tunnel(by: message)
      reconnectTunnel(configChanged: true)
      
    case .stop:
      stopCompletion = callbackWrapper
      
    case .getId:
      var data: Data? = nil
      
      if let tunnel {
        data = try? JSONSerialization.data(withJSONObject: [MessageKey.id.rawValue: tunnel.id], options: [])
      }
      
      completionHandler?(data)
    }
  }
  
  func retrieveTunnelConfig(with options: [String: NSObject]) -> Tunnel? {
    var tunnel: Tunnel?
    
    if options[MessageKey.onDemand.rawValue] == nil {
      tunnel = Tunnel(
        id: options[MessageKey.id.rawValue] as? String ?? "",
        config: options
      )
      
    } else {
      tunnel = tunnelStore.load()
    }
    
    return tunnel
  }
  
  func getClient() -> ShadowsocksClient? {
    guard let hostNetworkAddress, let tunnel else { return nil }
    
    let config = ShadowsocksConfig()
    config.host = hostNetworkAddress
    config.port = Int(tunnel.port) ?? 0
    config.password = tunnel.password
    config.cipherName = tunnel.method
    
    return ShadowsocksNewClient(config, nil)
  }
  
  func connectTunnel(settings: NEPacketTunnelNetworkSettings?, completion completionHandler: (((any Error)?) -> Void)?) {
    setTunnelNetworkSettings(settings) { [weak self] error in
      if error == nil {
        self?.reasserting = settings == nil
      }
      
      completionHandler?(error)
    }
  }
  
  func listenForNetworkChanges() {
    defaultPathObserver = observe(\.defaultPath, options: [.old]) { [weak self] _, change in
      guard let self, let defaultPath = self.defaultPath, let lastPath = change.oldValue?.unsafelyUnwrapped else { return }
      
      if lastPath.isEqual(to: defaultPath) || lastPath.description == defaultPath.description {
        return
      }
      
      DispatchQueue.main.async {
        self.handleNetworkChange(newDefaultPath: defaultPath)
      }
    }
  }
  
  func handleNetworkChange(newDefaultPath: NWPath) {
    if newDefaultPath.status == .satisfied {
      let isUdpSupported = tun2socksTunnel?.updateUDPSupport() ?? false
      tunnelStore.isUdpSupported = isUdpSupported
      reconnectTunnel(configChanged: false)
      
    } else {
      connectTunnel(settings: nil, completion: nil)
    }
  }
  
  func reconnectTunnel(configChanged: Bool) {
    guard let tunnel else {
      execAppCallback(for: .start, errorCode: .illegalServerConfiguration)
      return
    }
    
    let activeHostNetworkAddress = getNetworkIpAddress(tunnel.host)
    
    if let hostNetworkAddress, !configChanged && activeHostNetworkAddress == hostNetworkAddress {
      let settings = getTunnelNetworkSettings(tunnelRemoteAddress: hostNetworkAddress)
      
      connectTunnel(settings: settings) { error in
        if let error {
          self.cancelTunnelWithError(error)
        }
      }
      
      return
    }
    
    self.hostNetworkAddress = activeHostNetworkAddress
    
    guard let client = getClient() else {
      execAppCallback(for: .start, errorCode: .illegalServerConfiguration)
      cancelTunnelWithError(NSError(code: .configurationInvalid))
      return
    }
    
    var error = 0
    ShadowsocksCheckConnectivity(client, &error, nil)
    
    let errorCode = ErrorCode(rawValue: error) ?? .undefinedError
    
    if errorCode != .noError && errorCode != .udpRelayNotEnabled {
      execAppCallback(for: .start, errorCode: errorCode)
      cancelTunnelWithError(NSError(code: .connectionFailed))
      return
    }
    
    let isUdpSupported = errorCode == .noError
    
    if !startTun2Socks(isUdpSupported: isUdpSupported) {
      execAppCallback(for: .start, errorCode: .vpnStartFailure)
      cancelTunnelWithError(NSError(code: .connectionFailed))
      return
    }
    
    guard let hostNetworkAddress else { return }
    
    let settings = getTunnelNetworkSettings(tunnelRemoteAddress: hostNetworkAddress)
    
    connectTunnel(settings: settings) { error in
      if let error {
        self.execAppCallback(for: .start, errorCode: .vpnStartFailure)
        self.cancelTunnelWithError(error)
        return
      }
      
      self.tunnelStore.isUdpSupported = isUdpSupported
      self.tunnelStore.save(tunnel)
      self.execAppCallback(for: .start)
    }
  }
  
  func processPackets() {
    var bytesWritten = 0
    
    packetFlow.readPackets(completionHandler: { [weak self] packets, _ in
      for packet in packets {
        try? self?.tun2socksTunnel?.write(packet, ret0_: &bytesWritten)
      }
      
      self?.packetQueue.async {
        self?.processPackets()
      }
    })
  }
  
  func startTun2Socks(isUdpSupported: Bool) -> Bool {
    let isRestart = tun2socksTunnel?.isConnected() ?? false
    
    if isRestart {
      tun2socksTunnel?.disconnect()
    }
    
    guard let client = getClient() else {
      return false
    }
    
    weak var weakSelf = self
    var error: NSError?
    tun2socksTunnel = Tun2socksConnectShadowsocksTunnel(weakSelf, client, isUdpSupported, &error)
    
    if error != nil {
      return false
    }
    
    if !isRestart {
      packetQueue.async {
        self.processPackets()
      }
    }
    
    return true
  }
  
  func execAppCallback(for action: Action, errorCode: ErrorCode = .noError) {
    switch action {
    case .start where startCompletion != nil:
      startCompletion?(errorCode)
      startCompletion = nil
      
    case .stop where stopCompletion != nil:
      stopCompletion?(errorCode)
      stopCompletion = nil
      
    default:
      break
    }
  }
}

extension PacketTunnelProvider: Tun2socksTunWriterProtocol {
  func write(_ packet: Data?, n: UnsafeMutablePointer<Int>?) throws {
    if let packet {
      packetFlow.writePackets([packet], withProtocols: [NSNumber(value: AF_INET)])
    }
  }
  
  func close() throws {}
}

extension NSError {
  convenience init(code: NEVPNError.Code) {
    self.init(domain: NEVPNErrorDomain, code: code.rawValue, userInfo: nil)
  }
}
