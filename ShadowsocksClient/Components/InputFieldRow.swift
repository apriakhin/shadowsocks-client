//
//  InputFieldRow.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 21.06.2024.
//

import SwiftUI

struct InputFieldRow: View {
  @FocusState private var focused: Bool
  @Binding var text: String
  
  var label: LocalizedStringKey
  var placeholder: LocalizedStringResource
  var isAutoFocus: Bool = false
  
  var body: some View {
    HStack(spacing: 8) {
#if os(iOS)
      Text(label)
#endif
      TextField(label, text: $text, prompt: Text(placeholder))
        .focused($focused)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.plain)
    }
    .onAppear {
      focused = isAutoFocus
    }
  }
}

#Preview {
  Form {
    InputFieldRow(text: .constant(""), label: "Label", placeholder: "Placeholder")
  }
  .formStyle(.grouped)
}
