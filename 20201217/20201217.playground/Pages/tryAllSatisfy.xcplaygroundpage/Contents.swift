//: [Previous](@previous)

import Foundation
import Combine

// tryAllSatisfy(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryallsatisfy(_:)

struct RangeError: Error {}

let targetRange = (-1...100)
let numbers = [-1,10,5,0,99]

numbers.publisher
    .print("1: ")
    .tryAllSatisfy({ anInt in
        guard anInt != 0 else { throw RangeError() }
        return targetRange.contains(anInt)
    })
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


//: [Next](@next)
