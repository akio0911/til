//: [Previous](@previous)

import Foundation
import Combine

// max() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/max()

let numbers = [0,10,5]
let cancellable = numbers.publisher
    .max()
    .sink(receiveValue: {print($0)})


//: [Next](@next)
