//
//  Status.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import Foundation
import NetworkExtension

enum Status {
  case invalid
  case disconnected
  case connecting
  case connected
  case reasserting
  case disconnecting
  case unknown
}

extension Status {
  init(_ status: NEVPNStatus) {
    switch status {
    case .invalid:
      self = .invalid
    case .disconnected:
      self = .disconnected
    case .connecting:
      self = .connecting
    case .connected:
      self = .connected
    case .reasserting:
      self = .reasserting
    case .disconnecting:
      self = .disconnecting
    @unknown default:
      self = .unknown
    }
  }
}
