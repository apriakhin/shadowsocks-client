//
//  TunnelStatus.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 30.06.2024.
//

import Foundation

enum TunnelStatus: Int {
  case connected = 0
  case disconnected = 1
  case reconnecting = 2
}
