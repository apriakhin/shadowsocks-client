//
//  DisconnectFromDefaultServer.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 22.06.2024.
//

import AppIntents
import SwiftData

struct DisconnectFromDefaultServer: AppIntent {
  static var title: LocalizedStringResource = "Disconnect from default server"
  static var openAppWhenRun = false
  
  func perform() async throws -> some IntentResult {
    let dependencyFactory = DependencyFactory.shared
    let dataManager = dependencyFactory.dataManager
    let shadowsocksManager = dependencyFactory.shadowsocksManager
    
    guard let defaultServer = dataManager.defaultServer else {
      return .result()
    }
    
    shadowsocksManager.stop(by: defaultServer.id)
    
    return .result()
  }
}
