//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// prepend(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/prepend(_:)-7wk5l

//let dataElements = (0...10)
//let cancellable = dataElements.publisher
//    .prepend(0, 1, 255)
//    .sink(receiveValue: {print($0)})

let pub = PassthroughSubject<Int,Never>()

let cancellable = pub
    .prepend(1,2,3) // pubからの値を待たずに即流れる
    .sink(receiveValue: {print($0)})

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
    pub.send(10)
    pub.send(11)
    pub.send(12)
    pub.send(completion: .finished)
})

//: [Next](@next)
