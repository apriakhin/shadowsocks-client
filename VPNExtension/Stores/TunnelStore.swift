//
//  TunnelStore.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 23.06.2024.
//

import Foundation

final class TunnelStore {
  private let tunnelStoreKey = "connectionStore"
  private let tunnelStatusKey = "connectionStatus"
  private let udpSupportKey = "udpSupport"
  private let defaults: UserDefaults?
  
  init(appGroup: String) {
    defaults = UserDefaults(suiteName: appGroup)
  }
  
  func load() -> Tunnel? {
    guard let encodedTunnel = defaults?.data(forKey: tunnelStoreKey) else { return nil }
    
    return Tunnel.decode(encodedTunnel)
  }
  
  func save(_ tunnel: Tunnel) {
    if let encodedTunnel = tunnel.encode() {
      defaults?.set(encodedTunnel, forKey: tunnelStoreKey)
    }
  }
  
  var status: TunnelStatus {
    get {
      let status = defaults?.integer(forKey: tunnelStatusKey) ?? TunnelStatus.disconnected.rawValue
      return TunnelStatus(rawValue: status) ?? TunnelStatus.disconnected
    }
    set(newStatus) {
      defaults?.set(newStatus.rawValue, forKey: tunnelStatusKey)
    }
  }
  
  var isUdpSupported: Bool {
    get {
      return defaults?.bool(forKey: udpSupportKey) ?? false
    }
    set(udpSupport) {
      defaults?.set(udpSupport, forKey: udpSupportKey)
    }
  }
}
