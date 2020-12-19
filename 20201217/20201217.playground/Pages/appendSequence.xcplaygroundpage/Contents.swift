//: [Previous](@previous)

import Foundation
import Combine

// append(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/append(_:)-69sdn

let groundTransport = ["car", "bus", "truck", "subway", "bicycle"]
let airTransport = ["parasail", "jet", "helicopter", "rocket"]

let cancellable = groundTransport.publisher
    .append(airTransport)
    .sink(receiveValue: {print($0)})



//: [Next](@next)
