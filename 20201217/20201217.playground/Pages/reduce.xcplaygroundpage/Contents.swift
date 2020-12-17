//: [Previous](@previous)

import Foundation
import Combine

// reduce(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/reduce(_:_:)

let numbers = (0...10)
let cancellable = numbers.publisher
    .reduce(0, { acc, next in acc + next })
    .sink(receiveValue: {print($0)})


//: [Next](@next)
