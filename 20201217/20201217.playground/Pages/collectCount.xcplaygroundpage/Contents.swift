//: [Previous](@previous)

import Foundation
import Combine

// collect(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/collect(_:)

let numbers = (0...10)
let cancellable = numbers.publisher
    .collect(5)
    .sink(receiveValue: {print($0)})



//: [Next](@next)
