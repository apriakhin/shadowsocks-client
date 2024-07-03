//
//  ServerRow.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 30.06.2024.
//

import SwiftUI

struct ServerRow: View {
  let isChecked: Bool
  let title: String
  let country: Country
  let infoAction: () -> Void
  let action: () -> Void
  
  var body: some View {
    HStack(spacing: 12) {
      VStack {
        if isChecked {
          Image(systemName: "checkmark")
            .foregroundStyle(Color.accent)
            .bold()
        }
      }
      .frame(width: 16)
      
      Text(country.flag)
      
      VStack(alignment: .leading) {
        Text(title)
          .font(.body)
          .foregroundStyle(.primary)
        
        Text(country.name)
          .font(.footnote)
          .foregroundStyle(.secondary)
      }
      
      Spacer()
      
      Button(action: infoAction, label: {
        Image(systemName: "info.circle")
          .imageScale(.large)
      })
      .buttonStyle(.borderless)
    }
    .contentShape(Rectangle())
    .onTapGesture(perform: action)
  }
}

#Preview {
  List {
    ServerRow(isChecked: true, title: "Title", country: .russia, infoAction: {}, action: {})
  }
  .listStyle(.inset)
}
