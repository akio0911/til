import UIKit
import Combine

// map(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/map(_:)-99evh

let numbers = [5, 4, 3, 2, 1, 0]
let romanNumeralDict: [Int: String] = [
    1: "I",
    2: "II",
    3: "III",
    4: "IV",
    5: "V"
]
var cancellables = Set<AnyCancellable>()
numbers.publisher
    .map { romanNumeralDict[$0] ?? "(unknown)" }
    .sink(receiveValue: { print("\($0)", terminator: " ") })
    .store(in: &cancellables)

