//: [Previous](@previous)

import Foundation
import Combine

// tryContains(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trycontains(where:)

struct IllegalValueError: Error {}

let numbers = [3,2,10,5,0,9]
numbers.publisher
    .print("1: ")
    .tryContains(where: {
        if $0 % 2 == 0 {
            return $0 < 10
        } else {
            throw IllegalValueError()
        }
    })
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


//: [Next](@next)
