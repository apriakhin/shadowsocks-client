//
//  Config.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import Foundation

struct Config: Codable {
  let host: String
  let port: String
  let method: Method
  let password: String
}

extension Config {
  func toDictionary() -> [String: Any] {
    return [
      MessageKey.method.rawValue: method.rawValue,
      MessageKey.password.rawValue: password,
      MessageKey.host.rawValue: host,
      MessageKey.port.rawValue: port
    ]
  }
}
