//
//  Tunnel.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 23.06.2024.
//

import Foundation
import NetworkExtension

final class Tunnel: Codable {
  var id: String
  var host: String
  var port: String
  var method: String
  var password: String
  
  init(
    id: String,
    host: String,
    port: String,
    method: String,
    password: String
  ) {
    self.id = id
    self.host = host
    self.port = port
    self.method = method
    self.password = password
  }
  
  convenience init(id: String, config: [String: Any]) {
    self.init(
      id: id,
      host: config[MessageKey.host.rawValue] as? String ?? "",
      port: config[MessageKey.port.rawValue] as? String ?? "",
      method: config[MessageKey.method.rawValue] as? String ?? "",
      password: config[MessageKey.password.rawValue] as? String ?? ""
    )
  }
  
  convenience init(by message: [String: Any]) {
    self.init(
      id: message[MessageKey.id.rawValue] as? String ?? "",
      config: message[MessageKey.config.rawValue] as? [String: Any] ?? [:]
    )
  }
  
  var config: [String: String] {
    return [
      MessageKey.host.rawValue: host,
      MessageKey.port.rawValue: port,
      MessageKey.password.rawValue: password,
      MessageKey.method.rawValue: method,
    ]
  }
  
  func encode() -> Data? {
    return try? JSONEncoder().encode(self)
  }
  
  static func decode(_ jsonData: Data) -> Tunnel? {
    return try? JSONDecoder().decode(Tunnel.self, from: jsonData)
  }
}
