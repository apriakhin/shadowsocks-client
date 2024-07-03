//
//  ErrorCode.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 29.06.2024.
//

import Foundation

enum ErrorCode: Int {
  case noError = 0
  case undefinedError = 1
  case vpnPermissionNotGranted = 2
  case invalidServerCredentials = 3
  case udpRelayNotEnabled = 4
  case serverUnreachable = 5
  case vpnStartFailure = 6
  case illegalServerConfiguration = 7
  case shadowsocksStartFailure = 8
  case configureSystemProxyFailure = 9
  case noAdminPermissions = 10
  case unsupportedRoutingTable = 11
  case systemMisconfigured = 12
}

extension ErrorCode {
  init?(by message: [String: Any]) {
    guard let rawValue = message[MessageKey.errorCode.rawValue] as? Int,
          let errorCode = ErrorCode(rawValue: rawValue) 
    else { return nil }
    
    self = errorCode
  }
}
