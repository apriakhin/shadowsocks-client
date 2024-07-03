//
//  Method.swift
//  ShadowsocksClient
//
//  Created by Anton Priakhin on 14.06.2024.
//

import Foundation

enum Method: String, Codable, CaseIterable {
  case rc4Md5 = "rc4-md5"
  case aes128Gcm = "aes-128-gcm"
  case aes192Gcm = "aes-192-gcm"
  case aes256Gcm = "aes-256-gcm"
  case aes128Cfb = "aes-128-cfb"
  case aes192Cfb = "aes-192-cfb"
  case aes256Cfb = "aes-256-cfb"
  case aes128Ctr = "aes-128-ctr"
  case aes192Ctr = "aes-192-ctr"
  case aes256Ctr = "aes-256-ctr"
  case camellia128Cfb = "camellia-128-cfb"
  case camellia192Cfb = "camellia-192-cfb"
  case camellia256Cfb = "camellia-256-cfb"
  case bfCfb = "bf-cfb"
  case chacha20IetfPoly1305 = "chacha20-ietf-poly1305"
  case salsa20 = "salsa20"
  case chacha20 = "chacha20"
  case chacha20Ietf = "chacha20-ietf"
  case xchacha20IetfPoly1305 = "xchacha20-ietf-poly1305"
}
