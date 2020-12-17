//: [Previous](@previous)

import Foundation
import Combine

// collect() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/collect()

let numbers = (0...10)
let cancellable = numbers.publisher
    .collect()
    .sink(receiveValue: {print($0)})

//: [Next](@next)
