//: [Previous](@previous)

import Foundation
import Combine

// compactMap(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/compactmap(_:)

let numbers = (0...5)
let romanNumeralDict: [Int: String] = [1: "I", 2: "II", 3: "III", 5: "V"]
let cancellable = numbers.publisher
    .compactMap { romanNumeralDict[$0] }
    .sink(receiveValue: { print($0) })


//: [Next](@next)
