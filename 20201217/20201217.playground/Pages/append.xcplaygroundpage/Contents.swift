//: [Previous](@previous)

import Foundation
import Combine

// append(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/append(_:)-1qb8d

let dataElements = (0...10)
let cancellable = dataElements.publisher
    .append(0, 1, 255)
    .sink(receiveValue: {print($0)})



//: [Next](@next)
