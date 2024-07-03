//
//  URLParser.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 21.06.2024.
//

import Foundation

protocol URLParsing {
  func parse(url: String) -> Config?
}

struct URLParser {}

// MARK: - URLParsing

extension URLParser: URLParsing {
  func parse(url: String) -> Config? {
    return parseSIP002URI(url: url) ?? parseLegacyBase64URI(url: url)
  }
}

// MARK: - Private

private extension URLParser {
  func parseLegacyBase64URI(url: String) -> Config? {
    let urlPattern = #/ss:\/\/(?<configEncoded>.+?)($|#(?<tag>.+?))/#
    let configPattern = #/(?<method>.+?):(?<password>.+?)@(?<host>.+?):(?<port>\d+)/#

    guard let urlParams = try? urlPattern.wholeMatch(in: url),
          let config = String(urlParams.configEncoded).base64Decoded(),
          let configParams = try? configPattern.wholeMatch(in: config),
          let method = Method(rawValue: String(configParams.method)),
          let port = Int(configParams.port)
    else { return nil }
    
    let host = String(configParams.host)
    let password = String(configParams.password)
    
    return Config(
      host: host,
      port: String(port),
      method: method,
      password: password
    )
  }
  
  func parseSIP002URI(url: String) -> Config? {
    let urlString = url.replacingOccurrences(of: "ss://", with: "http://")
    let userInfoPattern = #/(?<method>.+?):(?<password>.+?)/#

    guard let url = URL(string: urlString),
          let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let host = components.host,
          let port = components.port,
          let userInfoEncoded = components.user,
          let userInfo = userInfoEncoded.base64Decoded(),
          let userInfoParams = try? userInfoPattern.wholeMatch(in: userInfo),
          let method = Method(rawValue: String(userInfoParams.method))
    else { return nil }
    
    let password = String(userInfoParams.password)
    
    return Config(
      host: host,
      port: String(port),
      method: method,
      password: password
    )
  }
}

// MARK: Fileprivate

fileprivate extension String {
  func base64Encoded() -> String? {
    return data(using: .utf8)?.base64EncodedString()
  }
  
  func base64Decoded() -> String? {
    guard let data = Data(base64Encoded: self) ?? Data(base64Encoded: "\(self)==") else { return nil }
    
    return String(data: data, encoding: .utf8)
  }
}
