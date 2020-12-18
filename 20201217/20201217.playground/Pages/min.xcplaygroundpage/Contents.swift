//: [Previous](@previous)

import Foundation
import Combine

// min() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/min()

let numbers = [-1, 0, 10, 5]
numbers.publisher
    .min()
    .sink { print($0) }


//: [Next](@next)
