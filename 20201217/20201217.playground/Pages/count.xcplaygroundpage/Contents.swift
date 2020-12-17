//: [Previous](@previous)

import Foundation
import Combine

// count() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/count()

let numbers = (0...10)
let cancellable = numbers.publisher
    .count()
    .sink(receiveValue: {print($0)})

//: [Next](@next)
