//: [Previous](@previous)

import Foundation
import Combine

// replaceError(with:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/replaceerror(with:)

struct MyError: Error {}
let fail = Fail<String, MyError>(error: MyError())
let cancellable = fail
    .replaceError(with: "(replacement element)")
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


//: [Next](@next)
