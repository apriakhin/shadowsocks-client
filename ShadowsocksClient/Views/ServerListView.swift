//
//  ServerListView.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 16.06.2024.
//

import SwiftUI
import SwiftData

struct ServerListView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @AppStorage(.defaultServerIdKey) private var defaultServerId: String?
  @Query private var servers: [Server]
  @Binding var appPath: [AppPath]
  
  private var defaultServer: Server? {
    servers.filter { $0.id == defaultServerId }.first ?? servers.first
  }
  
  var body: some View {
    List {
      Section {
        ForEach(servers) { server in
          ServerRow(
            isChecked: server == defaultServer,
            title: server.title,
            country: server.country,
            infoAction: {
              appPath.append(.editServer(server))
            },
            action: {
              withAnimation {
                defaultServerId = server.id
              }
            }
          )
        }
        .onDelete(perform: deleteItems)
      }
    }
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
    .navigationTitle("Servers")
    .listStyle(.inset)
    .toolbar {
#if os(iOS)
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
#else
      if let defaultServer {
        ToolbarItem(placement: .cancellationAction) {
          Button(action: {
            withAnimation {
              modelContext.delete(defaultServer)
            }
          }, label: {
            Image(systemName: "trash")
          })
        }
      }
#endif
      ToolbarItem(placement: .confirmationAction) {
        NavigationLink(value: AppPath.addServer(url: nil)) {
          Image(systemName: "plus")
        }
      }
    }
    .sensoryFeedback(.selection, trigger: defaultServerId)
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(servers[index])
      }
    }
  }
}

#Preview {
  ServerListView(appPath: .constant([]))
#if os(macOS)
    .frame(width: 400, height: 480)
#endif
}
