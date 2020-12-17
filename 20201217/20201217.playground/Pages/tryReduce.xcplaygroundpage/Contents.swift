//: [Previous](@previous)

import Foundation
import Combine

// tryReduce(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryreduce(_:_:)

struct DivisionByZeroError: Error {}
func myDivide(_ dividend: Double, _ divisor: Double) throws -> Double {
    guard divisor != 0 else { throw DivisionByZeroError() }
    return dividend / divisor
}

var numbers: [Double] = [5,4,3,2,1,0]
numbers.publisher
    .tryReduce(numbers.first!, { acc, next in try myDivide(acc, next)})
    .catch({ _ in Just(Double.nan) })
    .sink(receiveValue: {print($0)})


//: [Next](@next)
