//: [Previous](@previous)

import Foundation
import Combine

// tryCompactMap(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trycompactmap(_:)

struct ParseError: Error {}

func romanNumeral(from: Int) throws -> String? {
    let romanNumeralDict: [Int: String] = [1: "I", 2: "II", 3: "III", 4: "IV", 5: "V"]
    guard from != 0 else { throw ParseError() }
    return romanNumeralDict[from]
}

let numbers = [6,5,4,3,2,1,0]

let cancellable = numbers.publisher
    .tryCompactMap({ try romanNumeral(from: $0) })
    .sink(receiveCompletion: { print($0) }, receiveValue: { print($0) })



//: [Next](@next)
