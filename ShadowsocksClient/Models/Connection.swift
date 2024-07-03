//
//  Connection.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import Foundation
import Observation

@Observable final class Connection {
  // MARK: Dependencies
  
  private let shadowsocksManager: ShadowsocksManaging
  
  // MARK: State
  
  private(set) var status = Status.disconnected
  private(set) var connectedDate: Date?
  private(set) var errorMessage: LocalizedStringResource?
  
  // MARK: Init
  
  init(shadowsocksManager: ShadowsocksManaging) {
    self.shadowsocksManager = shadowsocksManager
    
    shadowsocksManager.onStatusChange = { status, connectedDate in
      self.status = status
      self.connectedDate = connectedDate
    }
  }
}

// MARK: - Internal

extension Connection {
  func toggle(defaultServer: Server) {
    errorMessage = nil
    
    switch status {
    case .disconnected, .invalid:
      Task {
        let errorCode = await shadowsocksManager.start(by: defaultServer.id, config: defaultServer.config)
        
        await MainActor.run {
          errorMessage = errorCode.message
        }
      }
      
    case .connected:
      shadowsocksManager.stop(by: defaultServer.id)
      
    default:
      break
    }
  }
}
