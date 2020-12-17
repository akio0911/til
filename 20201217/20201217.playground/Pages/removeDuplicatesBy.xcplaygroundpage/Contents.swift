//: [Previous](@previous)

import Foundation
import Combine

// removeDuplicates(by:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/removeduplicates(by:)

struct Point {
    let x: Int
    let y: Int
}

let points = [
    Point(x: 0, y: 0),
    Point(x: 0, y: 1),
    Point(x: 1, y: 1),
    Point(x: 2, y: 1),
]

let cancellable = points.publisher
    .removeDuplicates(by: { prev, current in
        prev.x == current.x
    })
    .sink(receiveValue: { print($0) })


//: [Next](@next)
