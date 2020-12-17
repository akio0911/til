//: [Previous](@previous)

import Foundation
import Combine

// tryRemoveDuplicates(by:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryremoveduplicates(by:)

struct BadValuesError: Error {}

let numbers = [0,0,0,0,1,2,2,3,3,3,4,4,4,4]
let cancellable = numbers.publisher
    .tryRemoveDuplicates(by: { first, second -> Bool in
        if first == 4 && second == 4 {
            throw BadValuesError()
        }
        return first == second
    }).sink(receiveCompletion: {print($0)},
            receiveValue: {print($0)})

//: [Next](@next)
