//: [Previous](@previous)

import Foundation
import Combine

// replaceEmpty(with:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/replaceempty(with:)

let numbers: [Double] = []
let cancellable = numbers.publisher
    .replaceEmpty(with: Double.nan)
    .sink(receiveValue: {print($0)})

let otherNumbers: [Double] = [1.0, 2.0, 3.0]
let cancellable2 = otherNumbers.publisher
    .replaceEmpty(with: Double.nan)
    .sink(receiveValue: {print($0)})

//: [Next](@next)
