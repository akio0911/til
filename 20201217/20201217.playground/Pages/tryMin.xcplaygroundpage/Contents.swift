//: [Previous](@previous)

import Foundation
import Combine

// tryMin(by:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trymin(by:)

struct IllegalValueError: Error {}

let numbers: [Int] = [0, 10, 6, 13, 22, 22]
numbers.publisher
    .tryMin(by: { first, second -> Bool in
        if first % 2 == 0 {
            return first < second
        } else {
            throw IllegalValueError()
        }
    })
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})

//: [Next](@next)
