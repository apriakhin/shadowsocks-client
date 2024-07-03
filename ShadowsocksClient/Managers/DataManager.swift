//
//  DataManager.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 22.06.2024.
//

import Foundation
import SwiftData

protocol DataManaging {
  var sharedModelContainer: ModelContainer { get }
  var defaultServer: Server? { get }
}

final class DataManager {
  private let modelContainer: ModelContainer = {
    let schema = Schema([Server.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  private lazy var modelContext: ModelContext = ModelContext(modelContainer)
  
  private var defaultServerId: String {
    UserDefaults.standard.string(forKey: .defaultServerIdKey) ?? ""
  }
}

// MARK: - DataManaging

extension DataManager: DataManaging {
  var sharedModelContainer: ModelContainer {
    return modelContainer
  }
  
  var defaultServer: Server? {
    let defaultDescriptor = FetchDescriptor<Server>(predicate: #Predicate<Server> { $0.id == defaultServerId })
    let allDescriptor = FetchDescriptor<Server>()
    
    return try? modelContext.fetch(defaultDescriptor).first ?? modelContext.fetch(allDescriptor).first
  }
}
