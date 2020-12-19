//: [Previous](@previous)

import Foundation
import Combine

// dropFirst(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/dropfirst(_:)

let numbers = (1...10)
let cancellable = numbers.publisher
    .dropFirst(5)
    .sink(receiveValue: {print($0)})


//: [Next](@next)
