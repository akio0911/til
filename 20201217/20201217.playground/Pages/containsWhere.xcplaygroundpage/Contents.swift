//: [Previous](@previous)

import Foundation
import Combine

// contains(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/contains(where:)

let numbers = [-1, 0, 10, 5]
numbers.publisher
    .handleEvents(receiveOutput: {print($0)})
    .contains(where: { $0 > 4 })
    .sink(receiveValue: {print($0)})



//: [Next](@next)
