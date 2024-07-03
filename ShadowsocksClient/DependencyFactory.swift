//
//  DependencyFactory.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 22.06.2024.
//

import Foundation
import Observation

@Observable final class DependencyFactory {
  static let shared: DependencyFactory = { DependencyFactory() }()
  
  let dataManager: DataManaging = DataManager()
  let shadowsocksManager: ShadowsocksManaging = ShadowsocksManager()
  let urlParser: URLParsing = URLParser()
  
  private init() {}
}
