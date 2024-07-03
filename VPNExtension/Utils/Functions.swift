//
//  Functions.swift
//  ShadowsocksKit
//
//  Created by Anton Priakhin on 30.06.2024.
//

import Foundation
import NetworkExtension

func getNetworkIpAddress(_ ipv4Str: String) -> String? {
  var hints = addrinfo(
    ai_flags: AI_DEFAULT,
    ai_family: PF_UNSPEC,
    ai_socktype: SOCK_STREAM,
    ai_protocol: 0,
    ai_addrlen: 0,
    ai_canonname: nil,
    ai_addr: nil,
    ai_next: nil
  )
  
  var info: UnsafeMutablePointer<addrinfo>?
  let error = getaddrinfo(ipv4Str, nil, &hints, &info)
  
  if error != 0 {
    return nil
  }
  
  var networkAddress = [CChar](repeating: 0, count: Int(INET6_ADDRSTRLEN))
  let success = getIpAddressString(info!.pointee.ai_addr, &networkAddress, socklen_t(INET6_ADDRSTRLEN))
  freeaddrinfo(info)
  
  if !success {
    return nil
  }
  
  return String(cString: networkAddress)
}

func getIpAddressString(_ sa: UnsafePointer<sockaddr>, _ s: UnsafeMutablePointer<Int8>, _ maxbytes: socklen_t) -> Bool {
  var sa_in = sa.withMemoryRebound(to: sockaddr_in.self, capacity: 1, { $0.pointee }) as sockaddr_in
  let family = sa_in.sin_family
  
  switch family {
  case sa_family_t(AF_INET):
    inet_ntop(AF_INET, &sa_in.sin_addr, s, maxbytes)
    
  case sa_family_t(AF_INET6):
    var sa_in6 = sa.withMemoryRebound(to: sockaddr_in6.self, capacity: 1, { $0.pointee }) as sockaddr_in6
    inet_ntop(AF_INET6, &sa_in6.sin6_addr, s, maxbytes)
    
  default:
    return false
  }
  
  return true
}

func getTunnelNetworkSettings(tunnelRemoteAddress: String) -> NEPacketTunnelNetworkSettings {
  let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: tunnelRemoteAddress)
  let vpnAddress = selectVpnAddress(interfaceAddresses: getNetworkInterfaceAddresses())
  let ipv4Settings = NEIPv4Settings(addresses: [vpnAddress], subnetMasks: ["255.255.255.0"])
  ipv4Settings.includedRoutes = [NEIPv4Route.default()]
  ipv4Settings.excludedRoutes = getExcludedIpv4Routes()
  settings.ipv4Settings = ipv4Settings
  settings.dnsSettings = NEDNSSettings(servers: ["1.1.1.1", "9.9.9.9", "208.67.222.222", "208.67.220.220"])
  return settings
}

func getNetworkInterfaceAddresses() -> [String] {
  var interfaces: UnsafeMutablePointer<ifaddrs>?
  var addresses = [String]()
  
  guard getifaddrs(&interfaces) == 0 else {
    return addresses
  }
  
  var interface = interfaces
  
  while interface != nil {
    if interface!.pointee.ifa_addr.pointee.sa_family == UInt8(AF_INET) {
      let addr = interface!.pointee.ifa_addr!.withMemoryRebound(to: sockaddr_in.self, capacity: 1) { $0.pointee.sin_addr }
      
      if let ip = String(cString: inet_ntoa(addr), encoding: .utf8) {
        addresses.append(ip)
      }
    }
    
    interface = interface!.pointee.ifa_next
  }
  
  freeifaddrs(interfaces)
  
  return addresses
}

func selectVpnAddress(interfaceAddresses: [String]) -> String {
  let vpnSubnetCandidates: [String: String] = [
    "10": "10.111.222.0",
    "172": "172.16.9.1",
    "192": "192.168.20.1",
    "169": "169.254.19.0"
  ]
  
  var candidates = vpnSubnetCandidates
  
  for address in interfaceAddresses {
    for subnetPrefix in vpnSubnetCandidates.keys {
      if address.hasPrefix(subnetPrefix) {
        candidates.removeValue(forKey: subnetPrefix)
      }
    }
  }
  
  guard !candidates.isEmpty else {
    return vpnSubnetCandidates.randomElement()!.value
  }
  
  return candidates.randomElement()!.value
}

func getExcludedIpv4Routes() -> [NEIPv4Route] {
  let excludedSubnets = [
    "10.0.0.0/8",
    "100.64.0.0/10",
    "169.254.0.0/16",
    "172.16.0.0/12",
    "192.0.0.0/24",
    "192.0.2.0/24",
    "192.31.196.0/24",
    "192.52.193.0/24",
    "192.88.99.0/24",
    "192.168.0.0/16",
    "192.175.48.0/24",
    "198.18.0.0/15",
    "198.51.100.0/24",
    "203.0.113.0/24",
    "240.0.0.0/4"
  ]
  
  var excludedIpv4Routes = [NEIPv4Route]()
  
  for cidrSubnet in excludedSubnets {
    if let subnet = Subnet.parse(cidrSubnet) {
      let route = NEIPv4Route(destinationAddress: subnet.address, subnetMask: subnet.mask)
      excludedIpv4Routes.append(route)
    }
  }
  
  return excludedIpv4Routes
}
