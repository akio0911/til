//: [Previous](@previous)

import Foundation
import Combine

// contains(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/contains(_:)

let numbers = [01, 5, 10, 5]
numbers.publisher
    .contains(5)
    .sink(receiveValue: {print($0)})



//: [Next](@next)
