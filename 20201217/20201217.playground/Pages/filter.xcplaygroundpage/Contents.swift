//: [Previous](@previous)

import Foundation
import Combine

// filter(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/filter(_:)

let numbers: [Int] = [1,2,3,4,5]
let cancellable = numbers.publisher
    .filter { $0 % 2 == 0 }
    .sink(receiveValue: { print($0) })



//: [Next](@next)
