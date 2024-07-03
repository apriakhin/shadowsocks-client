//
//  ServerDetailsView.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 14.06.2024.
//

import SwiftUI

struct ServerDetailsView: View {
  private enum ConfigureType: LocalizedStringResource, CaseIterable {
    case accessKey = "Access Key"
    case config = "Config"
  }
  
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @Environment(DependencyFactory.self) private var dependencyFactory
  @AppStorage(.defaultServerIdKey) private var defaultServerId: String?
  @State private var title = ""
  @State private var country: Country
  @State private var configureType = ConfigureType.accessKey
  @State private var url = ""
  @State private var host = ""
  @State private var port = ""
  @State private var method = Method.rc4Md5
  @State private var password = ""
  @State private var errorMessage: LocalizedStringResource?
  @State private var isShowingAlert = false
  
  private var urlParser: URLParsing { dependencyFactory.urlParser }
  
  private var server: Server?
  
  private var isDoneButtonDisabled: Bool {
    switch configureType {
    case .accessKey:
      return title.isEmpty || url.isEmpty
    case .config:
      return title.isEmpty || host.isEmpty || port.isEmpty || password.isEmpty
    }
  }
  
  private var isAutoFocusTitleField: Bool {
    return server == nil
  }
  
  private let countries: [Country] = Country.allCases.sorted(by: {
    String(localized: $0.name) < String(localized: $1.name)
  })
  
  private var navigationTitle: LocalizedStringKey {
    return server != nil ? LocalizedStringKey(title) : "New server"
  }
  
  init(url: String? = nil, server: Server? = nil) {
    self._country = State(initialValue: countries.first ?? .russia)
    self._url = State(initialValue: url ?? "")
    self.server = server
  }
  
  var body: some View {
    Form {
      Section("General") {
        InputFieldRow(text: $title, label: "Title", placeholder: "My server", isAutoFocus: isAutoFocusTitleField)
        
        Picker("Country", selection: $country) {
          ForEach(countries, id: \.self) {
            Text($0.formattedString)
          }
        }
        .pickerStyle(.menu)
      }
      
      Section("Config") {
        if server == nil {
          Picker("Configure", selection: $configureType) {
            ForEach(ConfigureType.allCases, id: \.self) { Text($0.rawValue) }
          }
          .pickerStyle(.menu)
        }
        
        switch configureType {
        case .accessKey:
          InputFieldRow(text: $url, label: "URL", placeholder: "ss://access-key")
          
        case .config:
          Picker("Method", selection: $method) {
            ForEach(Method.allCases, id: \.self) { Text($0.rawValue) }
          }
          .pickerStyle(.menu)
          
          InputFieldRow(text: $host, label: "Host", placeholder: "0.0.0.0")
          InputFieldRow(text: $port, label: "Port", placeholder: "5555")
          InputFieldRow(text: $password, label: "Password", placeholder: "Password")
        }
      }
    }
#if os(iOS)
    .navigationBarTitleDisplayMode(.inline)
#endif
    .navigationTitle(navigationTitle)
    .formStyle(.grouped)
    .toolbar {
      ToolbarItem(placement: .confirmationAction) {
        Button("Done", action: tapDone)
          .disabled(isDoneButtonDisabled)
      }
    }
    .onAppear {
      if let server {
        configureType = ConfigureType.config
        title = server.title
        country = server.country
        host = server.config.host
        port = server.config.port
        method = server.config.method
        password = server.config.password
      }
    }
    .alert(isPresented: $isShowingAlert) {
      Alert(
        title: Text("Error"),
        message: Text(errorMessage ?? ""),
        dismissButton: .default(Text("OK"))
      )
    }
    .onChange(of: errorMessage, initial: false) {
      if errorMessage != nil {
        isShowingAlert = true
      }
    }
    .onChange(of: isShowingAlert, initial: false) {
      if isShowingAlert == false {
        errorMessage = nil
      }
    }
    .onOpenURL { url in
      self.url = url.absoluteString
    }
  }
  
  func tapDone() {
    let config: Config
    
    switch configureType {
    case .accessKey:
      guard let configFromURL = urlParser.parse(url: url) else {
        errorMessage = "Incorrect access key"
        return
      }
      config = configFromURL
      
    case .config:
      config = Config(
        host: host,
        port: port,
        method: method,
        password: password
      )
    }
    
    if let server {
      server.title = title
      server.country = country
      server.config = config
      
    } else {
      let server = Server(
        title: title,
        country: country,
        config: config
      )
      
      modelContext.insert(server)
      defaultServerId = server.id
    }
    
    dismiss()
  }
}

#Preview {
  NavigationStack {
    ServerDetailsView()
  }
#if os(macOS)
  .frame(width: 400, height: 480)
#endif
}
