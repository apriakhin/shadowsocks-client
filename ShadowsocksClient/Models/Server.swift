//
//  Server.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 13.06.2024.
//

import Foundation
import SwiftData

@Model
final class Server: Hashable {
  var id: String
  var title: String
  var country: Country
  var config: Config
  
  init(
    id: String = UUID().uuidString,
    title: String,
    country: Country,
    config: Config
  ) {
    self.id = id
    self.title = title
    self.country = country
    self.config = config
  }
}
