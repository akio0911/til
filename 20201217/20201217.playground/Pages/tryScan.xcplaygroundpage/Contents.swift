//: [Previous](@previous)

import Foundation
import Combine

// tryScan(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryscan(_:_:)

struct DivisionByZeroError: Error {}

func myThrowingFunction(_ lastValue: Int, _ currentValue: Int) throws -> Int {
    guard currentValue != 0 else { throw DivisionByZeroError() }
    return (lastValue + currentValue) / currentValue
}

let numbers = [1,2,3,4,5,0,6,7,8,9]
let cancellable = numbers.publisher
    .tryScan(10, { try myThrowingFunction($0, $1) })
    .sink(receiveCompletion: { print("\($0)") },
          receiveValue: { print("\($0)", terminator: " ") })


//: [Next](@next)
