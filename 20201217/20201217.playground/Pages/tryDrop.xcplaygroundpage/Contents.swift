//: [Previous](@previous)

import Foundation
import Combine

// tryDrop(while:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trydrop(while:)

struct RangeError: Error {}
var numbers = [1,2,3,4,5,6,-1,7,8,9,10]
let range: CountableClosedRange<Int> = (1...100)
let cancellable = numbers.publisher
    .tryDrop(while: {
        guard $0 != 0 else { throw RangeError() }
        return range.contains($0)
    })
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})

//: [Next](@next)

