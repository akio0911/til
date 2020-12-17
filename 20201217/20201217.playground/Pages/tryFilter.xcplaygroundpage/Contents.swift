//: [Previous](@previous)

import Foundation
import Combine

// tryFilter(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryfilter(_:)

struct DivisionByZeroError: Error {}

let numbers: [Int] = [1,2,3,4,0,5]
let cancellable = numbers.publisher
    .tryFilter({
        if $0 == 0 {
            throw DivisionByZeroError()
        } else {
            return $0 % 2 == 0
        }
    })
    .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })


//: [Next](@next)
