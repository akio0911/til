//: [Previous](@previous)

import Foundation
import Combine

// removeDuplicates() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/removeduplicates()

let numbers = [0,1,2,2,3,3,3,4,4,4,4,0]
let cancellable = numbers.publisher
    .removeDuplicates()
    .sink(receiveValue: { print($0) })

//: [Next](@next)
