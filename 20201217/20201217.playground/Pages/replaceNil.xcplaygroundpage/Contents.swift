//: [Previous](@previous)

import Foundation
import Combine

// replaceNil(with:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/replacenil(with:)

let numbers: [Double?] = [1.0, 2.0, nil, 3.0]
let cancellable = numbers.publisher
    .replaceNil(with: 0.0)
    .sink(receiveValue: { print("\($0 as Any)", terminator: " ") })
    


//: [Next](@next)
