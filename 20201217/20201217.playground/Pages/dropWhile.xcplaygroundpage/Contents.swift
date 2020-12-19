//: [Previous](@previous)

import Foundation
import Combine

// drop(while:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/drop(while:)

let numbers = [-62, -1, 0, 10, 0, 22, 41, -1, 5]
let cancellable = numbers.publisher
    .drop(while: { $0 <= 0 })
    .sink(receiveValue: {print($0)})


//: [Next](@next)
