//: [Previous](@previous)

import Foundation
import Combine

// ignoreOutput() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/ignoreoutput()

struct NoZeroValuesAllowedError: Error {}
let numbers = [1,2,3,4,5,0,6,7,8,9]
let cancellable = numbers.publisher
    .tryFilter({ anInt in
        guard anInt != 0 else { throw NoZeroValuesAllowedError() }
        return anInt < 20
    })
    .ignoreOutput()
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


//: [Next](@next)
