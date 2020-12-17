//: [Previous](@previous)

import Foundation
import Combine

// mapError(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/maperror(_:)

struct DivisionByZeroError: Error {}
struct MyGenericError: Error { var wrappedError: Error }

func myDivide(_ dividend: Double, _ divisor: Double) throws -> Double {
    guard divisor != 0 else { throw DivisionByZeroError() }
    return dividend / divisor
}

let divisors: [Double] = [5, 4, 3, 2, 1, 0]
divisors.publisher
    .tryMap { try myDivide(1, $0) }
    .mapError { MyGenericError(wrappedError: $0) }
    .sink(
        receiveCompletion: { print("completion: \($0)") },
        receiveValue: { print("value: \($0)", terminator: " ") }
    )


//: [Next](@next)
