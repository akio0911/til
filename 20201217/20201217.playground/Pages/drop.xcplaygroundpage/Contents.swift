//: [Previous](@previous)

import Foundation
import Combine

// drop(untilOutputFrom:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/drop(untiloutputfrom:)

let upstream = PassthroughSubject<Int,Never>()
let second = PassthroughSubject<String,Never>()
let cancellable = upstream
    .drop(untilOutputFrom: second)
    .sink(receiveValue: {print($0)})

upstream.send(1)
upstream.send(2)
second.send("A")
upstream.send(3)
upstream.send(4)


//: [Next](@next)
