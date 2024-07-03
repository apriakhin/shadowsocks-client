//
//  StatusView.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI

struct StatusView: View {
  var status: Status
  
  private var dotColor: Color {
    switch status {
    case .connected: .green
    case .disconnecting, .connecting, .reasserting: .yellow
    default: .red
    }
  }
  
  private var statusText: LocalizedStringResource {
    switch status {
    case .connected: "Connected"
    case .connecting: "Connecting..."
    case .reasserting: "Reasserting..."
    case .disconnecting: "Disconnecting..."
    default: "Disconnected"
    }
  }
  
  var body: some View {
    HStack(spacing: 8) {
      Circle()
        .fill(dotColor)
        .frame(width: 8, height: 8)
      
      Text(statusText)
        .font(.body)
    }
  }
}

#Preview {
  StatusView(status: .connected)
}
