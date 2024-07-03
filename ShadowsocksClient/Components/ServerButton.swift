//
//  ServerButton.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import SwiftUI

struct ServerButton: View {
  var name: String
  var country: Country
  var action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: 16) {
        ZStack {
          RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
            .fill(Color.gray)
            .opacity(0.2)
            .frame(width: Constants.size, height: Constants.size)
          Text(country.flag)
            .font(.title)
        }
        
        VStack(alignment: .leading) {
          Text(name)
            .font(.body)
            .foregroundStyle(.primary)
          Text(country.name)
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        
        Image(systemName: "chevron.right")
          .foregroundStyle(.tertiary)
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  ServerButton(name: "Server", country: .russia, action: {})
}

// MARK: - Private

private enum Constants {
#if os(iOS)
  static var size: CGFloat { 56 }
  static var cornerRadius: CGFloat { 12 }
#else
  static var size: CGFloat { 44 }
  static var cornerRadius: CGFloat { 10 }
#endif
}
