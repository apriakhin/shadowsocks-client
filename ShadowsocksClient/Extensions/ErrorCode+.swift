//
//  ErrorCode+.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 29.06.2024.
//

import Foundation

extension ErrorCode {
  var message: LocalizedStringResource? {
    switch self {
    case .noError: nil
    case .undefinedError: "Undefined error"
    case .vpnPermissionNotGranted: "VPN permission not granted"
    case .invalidServerCredentials: "Invalid server credentials"
    case .udpRelayNotEnabled: "UDP relay not enabled"
    case .serverUnreachable: "Server unreachable"
    case .vpnStartFailure: "VPN start failure"
    case .illegalServerConfiguration: "Illegal server configuration"
    case .shadowsocksStartFailure: "Shadowsocks start failure"
    case .configureSystemProxyFailure: "Configure system proxy is failure"
    case .noAdminPermissions: "No admin permissions"
    case .unsupportedRoutingTable: "Unsupported routing table"
    case .systemMisconfigured: "System misconfigured"
    }
  }
}
