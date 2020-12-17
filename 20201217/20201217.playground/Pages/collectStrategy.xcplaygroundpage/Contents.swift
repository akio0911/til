//: [Previous](@previous)

import Foundation
import Combine

// collect(_:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/collect(_:options:)

let sub = Timer.publish(every: 1, on: .main, in: .default)
    .autoconnect()
    .collect(.byTimeOrCount(RunLoop.main, .seconds(5), 5))
    .sink(receiveValue: {print($0)})


//: [Next](@next)
