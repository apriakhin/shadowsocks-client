//
//  AppPath.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 30.06.2024.
//

import Foundation

enum AppPath: Hashable {
  case addServer(url: String?)
  case editServer(Server)
  case serverList
}
