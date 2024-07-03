//
//  ShadowsocksClientApp.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI
import SwiftData

@main
struct ShadowsocksClientApp: App {
  private let dependencyFactory: DependencyFactory
  @State private var connection: Connection
  
  init() {
    dependencyFactory = DependencyFactory.shared
    _connection = State(initialValue: Connection(shadowsocksManager: dependencyFactory.shadowsocksManager))
  }
  
  var body: some Scene {
    WindowGroup {
      ServerConnectionView()
        .environment(dependencyFactory)
        .environment(connection)
#if os(macOS)
        .frame(width: 400, height: 480)
#endif
    }
    .modelContainer(dependencyFactory.dataManager.sharedModelContainer)
#if os(macOS)
    .windowResizability(.contentSize)
    .windowToolbarStyle(.unifiedCompact)
#endif
  }
}
