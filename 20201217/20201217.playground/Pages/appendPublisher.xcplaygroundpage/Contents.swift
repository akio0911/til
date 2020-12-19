//: [Previous](@previous)

import Foundation
import Combine

// append(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/append(_:)-5yh02

let numbers = (0...10)
let otherNumbers = (25...35)
let cancellable = numbers.publisher
    .append(otherNumbers.publisher)
    .sink(receiveValue: {print($0)})


//: [Next](@next)
