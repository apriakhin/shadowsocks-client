//
//  ServerConnectionView.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI
import SwiftData

struct ServerConnectionView: View {
  @Environment(Connection.self) private var connection
  @AppStorage(.defaultServerIdKey) private var defaultServerId: String?
  @Query private var servers: [Server]
  @State private var appPath = [AppPath]()
  @State private var isShowingAlert = false
  
  private var defaultServer: Server? {
    return servers.filter { $0.id == defaultServerId }.first ?? servers.first
  }
  
  private var isButtonDisabled: Bool {
    switch connection.status {
    case .disconnected, .invalid:
      return false
    default:
      return true
    }
  }
  
  private var isConnected: Bool {
    return connection.status == .connected || connection.status == .disconnecting
  }
  
  var body: some View {
    NavigationStack(path: $appPath) {
      VStack(spacing: .zero) {
        Spacer()
        
        VStack(spacing: 16) {
          TimerView(connectedDate: connection.connectedDate)
          
          StatusView(status: connection.status)
        }
        
        Spacer()
        
        ToggleButton(isAnimating: isConnected) {
          if let defaultServer {
            connection.toggle(defaultServer: defaultServer)
          }
        }
        .disabled(defaultServer == nil)
        
        Spacer()
        
        if let defaultServer {
          ServerButton(
            name: defaultServer.title,
            country: defaultServer.country
          ) {
            appPath.append(AppPath.serverList)
          }
          .disabled(isButtonDisabled)
          
        } else {
          NavigationLink("Add Server", value: AppPath.addServer(url: nil))
        }
        
        Spacer()
      }
      .ignoresSafeArea()
      .toolbar {
        ToolbarItem(placement: .confirmationAction) {
          NavigationLink(value: AppPath.addServer(url: nil)) {
            Image(systemName: "plus")
          }
          .disabled(isButtonDisabled)
        }
      }
      .navigationDestination(for: AppPath.self) { appPath in
        switch appPath {
        case .addServer(let url):
          ServerDetailsView(url: url)
          
        case .editServer(let server):
          ServerDetailsView(server: server)
          
        case .serverList:
          ServerListView(appPath: $appPath)
        }
      }
      .alert(isPresented: $isShowingAlert) {
        Alert(
          title: Text("Error"),
          message: Text(connection.errorMessage ?? ""),
          dismissButton: .default(Text("OK"))
        )
      }
      .onChange(of: connection.errorMessage, initial: false) {
        if connection.errorMessage != nil {
          isShowingAlert = true
        }
      }
      .sensoryFeedback(.success, trigger: isConnected)
      .sensoryFeedback(.error, trigger: isShowingAlert) { _, newValue in
        newValue == true
      }
    }
    .onOpenURL { url in
      if isConnected, let defaultServer {
        connection.toggle(defaultServer: defaultServer)
      }
      
      if let last = appPath.last {
        switch last {
        case .addServer:
          break
          
        case .editServer:
          appPath.removeLast()
          appPath.append(AppPath.addServer(url: url.absoluteString))
          
        case .serverList:
          appPath.removeLast()
          appPath.append(AppPath.addServer(url: url.absoluteString))
        }
        
      } else {
        appPath.append(AppPath.addServer(url: url.absoluteString))
      }
    }
  }
}

#Preview {
  ServerConnectionView()
    .environment(Connection(shadowsocksManager: DependencyFactory.shared.shadowsocksManager))
#if os(macOS)
    .frame(width: 400, height: 480)
#endif
}
