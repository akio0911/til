//: [Previous](@previous)

import Foundation
import Combine

// min(by:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/min(by:)

enum Rank: Int {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

let cards: [Rank] = [.five, .queen, .ace, .eight, .king]
let cancellable = cards.publisher
    .min {
        return $0.rawValue < $1.rawValue
    }
    .sink(receiveValue: {print($0)})

//: [Next](@next)
