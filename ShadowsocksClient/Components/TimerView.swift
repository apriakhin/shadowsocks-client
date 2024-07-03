//
//  TimerView.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI

struct TimerView: View {
  var connectedDate: Date?
  
  var body: some View {
    if let connectedDate {
      Text(connectedDate, style: .timer)
        .font(.largeTitle)
      
    } else {
      Text("0:00")
        .font(.largeTitle)
    }
  }
}

#Preview {
  TimerView()
}
