//: [Previous](@previous)

import Foundation
import Combine

// prefix(while:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/prefix(while:)

let numbers = (0...10)
numbers.publisher
    .prefix(while: { $0 < 5 })
    .sink(receiveValue: {print($0)})

//: [Next](@next)
