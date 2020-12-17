//: [Previous](@previous)

import Foundation
import Combine

// scan(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/scan(_:_:)

// ReactiveX - Scan operator
// http://reactivex.io/documentation/operators/scan.html

let range = (0...5)
let cancellable = range.publisher
    .scan(0, { return $0 + $1 })
    .sink(receiveValue: { print("\($0)", terminator: " ") })
// 0 1 3 6 10 15


//: [Next](@next)
