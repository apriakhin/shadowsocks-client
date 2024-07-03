//
//  Action.swift
//  VPNExtension
//
//  Created by Anton Priakhin on 29.06.2024.
//

import Foundation

enum Action: String {
  case start = "start"
  case restart = "restart"
  case stop = "stop"
  case getId = "getId"
}

extension Action {
  init?(by message: [String: Any]) {
    guard let rawValue = message[MessageKey.action.rawValue] as? String,
          let action = Action(rawValue: rawValue)
    else { return nil }
    
    self = action
  }
}
