//: [Previous](@previous)

import Foundation
import Combine

// prepend(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/prepend(_:)-v9sb

let prefixValues = [0,1,255]
let dataElements = (0...10)
let cancellable = dataElements.publisher
    .prepend(prefixValues)
    .sink(receiveValue: {print($0)})



//: [Next](@next)
