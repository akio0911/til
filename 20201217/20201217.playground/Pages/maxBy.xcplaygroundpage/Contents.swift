//: [Previous](@previous)

import Foundation
import Combine

enum Rank: Int {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
}

let cards: [Rank] = [.five, .queen, .ace, .eight, .jack]
let cancellable = cards.publisher
    .max { $0.rawValue < $1.rawValue }
    .sink(receiveValue: {print($0)})

//: [Next](@next)
