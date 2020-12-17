//: [Previous](@previous)

import Foundation
import Combine

// tryMax(by:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trymax(by:)

struct IllegalValueError: Error {}

let numbers: [Int] = [0, 10, 6, 13, 22, 22]
let cancellable = numbers.publisher
    .tryMax(by: { first, second -> Bool in
        if first % 2 == 0 {
            return first < second
        } else {
            throw IllegalValueError()
        }
    })
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


//: [Next](@next)
