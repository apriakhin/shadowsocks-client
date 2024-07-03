//
//  ShadowsocksManager.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 21.06.2024.
//

import NetworkExtension

protocol ShadowsocksManaging: AnyObject {
  var onStatusChange: ((Status, Date?) -> Void)? { get set }
  
  func start(by id: String, config: Config) async -> ErrorCode
  func stop(by id: String)
  func isActive(by id: String) -> Bool
}

final class ShadowsocksManager {
  private var tunnelProviderManager: NETunnelProviderManager?
  private var activeId: String?
  private var statusObserver: NSObjectProtocol?
  private var statusChangeHandler: ((Status, Date?) -> Void)?
  
  init() {
    Task {
      tunnelProviderManager = try await NETunnelProviderManager.loadAllFromPreferences().first ?? NETunnelProviderManager()
      
      await MainActor.run {
        statusDidChange()
      }
    }
    
    statusObserver = NotificationCenter.default.addObserver(forName: .NEVPNStatusDidChange, object: nil, queue: nil) { _ in
      self.statusDidChange()
    }
  }
}

// MARK: - ShadowsocksManaging

extension ShadowsocksManager: ShadowsocksManaging {
  var onStatusChange: ((Status, Date?) -> Void)? {
    get {
      statusChangeHandler
    }
    set {
      statusChangeHandler = newValue
    }
  }
  
  func start(by id: String, config: Config) async -> ErrorCode {
    guard !isActive(by : id) else { return .noError }
    
    if isVpnConnected {
      return await restartVpn(id: id, config: config)
    }
    
    return await startVpn(id: id, config: config)
  }
  
  func stop(by id: String) {
    guard isActive(by: id) else { return }
    
    stopVpn()
  }
  
  func isActive(by id: String) -> Bool {
    return activeId == id && isVpnConnected
  }
}

// MARK: - Private

private extension ShadowsocksManager {
  var session: NETunnelProviderSession? {
    tunnelProviderManager?.connection as? NETunnelProviderSession
  }
  
  var status: NEVPNStatus? {
    tunnelProviderManager?.connection.status
  }
  
  var connectedDate: Date? {
    tunnelProviderManager?.connection.connectedDate
  }
  
  var isVpnConnected: Bool {
    guard let status else { return false }
    
    return status == .connected || status == .connecting || status == .reasserting
  }
  
  func setupVpn() async throws {
    let managers = try await NETunnelProviderManager.loadAllFromPreferences()
    var manager: NETunnelProviderManager!
    
    if !managers.isEmpty {
      manager = managers.first
      let hasOnDemandRules = !(manager.onDemandRules?.isEmpty ?? true)
      
      if manager.isEnabled && hasOnDemandRules {
        tunnelProviderManager = manager
        return
      }
      
    } else {
      let config = NETunnelProviderProtocol()
      config.providerBundleIdentifier = "ru.apriakhin.ShadowsocksClient.VPNExtension"
      config.serverAddress = "Shadowsocks"
      manager = NETunnelProviderManager()
      manager.protocolConfiguration = config
    }
    
    let connectRule = NEOnDemandRuleConnect()
    connectRule.interfaceTypeMatch = .any
    manager.onDemandRules = [connectRule]
    manager.isEnabled = true
    try await manager.saveToPreferences()
    
    tunnelProviderManager = manager
    try await tunnelProviderManager?.loadFromPreferences()
  }
  
  func startVpn(id: String, config: Config) async -> ErrorCode {
    do {
      try await setupVpn()
      
      var options = config.toDictionary()
      options[MessageKey.id.rawValue] = id
      
      do {
        try session?.startTunnel(options: options)
      } catch {
        return .vpnStartFailure
      }
      
      let message = [
        MessageKey.action.rawValue: Action.start.rawValue,
        MessageKey.id.rawValue: id
      ]
      
      let response = await sendVpnExtensionMessage(message)
      return onStartVpnExtensionMessage(response)
      
    } catch {
      return .vpnPermissionNotGranted
    }
  }
  
  func stopVpn() {
    session?.stopTunnel()
    setConnectVpnOnDemand(false)
    activeId = nil
  }
  
  func restartVpn(id: String, config: Config) async -> ErrorCode {
    let message: [String: Any] = [
      MessageKey.action.rawValue: Action.restart.rawValue,
      MessageKey.id.rawValue: id,
      MessageKey.config.rawValue: config.toDictionary()
    ]
    
    let response = await sendVpnExtensionMessage(message)
    return onStartVpnExtensionMessage(response)
  }
  
  func setConnectVpnOnDemand(_ enabled: Bool) {
    tunnelProviderManager?.isOnDemandEnabled = enabled
    tunnelProviderManager?.saveToPreferences()
  }
  
  func retrieveActiveId() async {
    let response = await sendVpnExtensionMessage([MessageKey.action.rawValue: Action.getId.rawValue])
    guard let activeId = response?[MessageKey.id.rawValue] as? String else { return }
    
    self.activeId = activeId
  }
  
  func statusDidChange() {
    if let status {
      if activeId != nil {
        if (status == .disconnected) {
          activeId = nil
        }
        
      } else if status == .connected {
        Task {
          await retrieveActiveId()
        }
      }
      
      statusChangeHandler?(Status(status), connectedDate)
    }
  }
  
  func sendVpnExtensionMessage(_ message: [String: Any]) async -> [String: Any]? {
    guard let data = try? JSONSerialization.data(withJSONObject: message, options: []) else { return nil }
    
    return await withCheckedContinuation { (continuation: CheckedContinuation<[String: Any]?, Never>) in
      do {
        try session?.sendProviderMessage(data) { data in
          guard let data, let response = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            continuation.resume(returning: nil)
            return
          }
          
          continuation.resume(returning: response)
        }
      } catch {
        continuation.resume(returning: nil)
      }
    }
  }
  
  func onStartVpnExtensionMessage(_ message: [String: Any]?) -> ErrorCode {
    guard let message, let errorCode = ErrorCode(by: message) else { return .vpnStartFailure }
    
    if errorCode == .noError, let id = message[MessageKey.id.rawValue] as? String {
      activeId = id
      setConnectVpnOnDemand(true)
    }
    
    return errorCode
  }
}
