//: [Previous](@previous)

import Foundation
import Combine

// setFailureType(to:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/setfailuretype(to:)

let pub1 = [0,1,2,3,4,5].publisher
let pub2 = CurrentValueSubject<Int, Error>(0)
let cancellable = pub1
    .setFailureType(to: Error.self)
    .combineLatest(pub2)
    .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })


//: [Next](@next)
