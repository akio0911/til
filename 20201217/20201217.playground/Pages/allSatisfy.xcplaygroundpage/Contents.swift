//: [Previous](@previous)

import Foundation
import Combine

// allSatisfy(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/allsatisfy(_:)

let targetRange = (-1...100)
let numbers = [-1,0,10,5]
numbers.publisher
    .allSatisfy({ targetRange.contains($0) })
    .sink(receiveValue: {print($0)})


//: [Next](@next)
