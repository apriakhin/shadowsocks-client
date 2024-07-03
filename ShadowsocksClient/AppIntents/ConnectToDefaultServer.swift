//
//  ConnectToDefaultServer.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 22.06.2024.
//

import AppIntents

struct ConnectToDefaultServer: AppIntent {
  static var title: LocalizedStringResource = "Connect to default server"
  static var openAppWhenRun = false
  
  func perform() async throws -> some IntentResult {
    let dependencyFactory = DependencyFactory.shared
    let dataManager = dependencyFactory.dataManager
    let shadowsocksManager = dependencyFactory.shadowsocksManager
    
    guard let defaultServer = dataManager.defaultServer else {
      return .result()
    }
    
    _ = await shadowsocksManager.start(by: defaultServer.id, config: defaultServer.config)
    
    return .result()
  }
}
