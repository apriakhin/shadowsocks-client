// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Tun2socks",
  products: [.library(name: "Tun2socks", targets: ["Tun2socks"])],
  targets: [
    .binaryTarget(
      name: "Tun2socks",
      url: "https://github.com/Jigsaw-Code/outline-go-tun2socks/releases/download/v3.4.0/apple.zip",
      checksum: "6c6880fa7d419a5fddc10588edffa0b23b5a44f0f840cf6865372127285bcc42"
    ),
  ]
)
