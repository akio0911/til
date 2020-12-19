//: [Previous](@previous)

import Foundation
import Combine

// prefix(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/prefix(_:)

let numbers = (0...10)
let cancellable = numbers.publisher
    .prefix(2)
    .sink(receiveValue: {print($0)})


//: [Next](@next)
