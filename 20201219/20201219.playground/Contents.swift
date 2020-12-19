import UIKit
import Combine

// tryPrefix(while:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryprefix(while:)
func tryPrefixWhile() {
    struct OutOfRangeError: Error {}
    
    let numbers = (0...10).reversed()
    let cancellable = numbers.publisher
        .tryPrefix(while: {
            guard $0 != 0 else { throw OutOfRangeError() }
            return $0 <= numbers.max()!
        })
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

// prefix(untilOutputFrom:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/prefix(untiloutputfrom:)
func prefixUntilOutputFrom() {
    let pub1 = PassthroughSubject<Int,Never>()
    let pub2 = PassthroughSubject<Int,Never>()
    
    pub1
        .prefix(untilOutputFrom: pub2)
        .sink(receiveValue: {print($0)})
    
    pub1.send(1)
    pub1.send(2)
    pub1.send(3)

    pub2.send(99)
    
    pub1.send(4)
    pub1.send(5)
}

// first() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/first()
func first() {
    let numbers = (-10...10)
    let cancellable = numbers.publisher
        .first()
        .sink(receiveValue: {print($0)})
}

// first(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/first(where:)
func firstWhere() {
    let numbers = (-10...10)
    let cancellable = numbers.publisher
        .first(where: { $0 > 0 })
        .sink(receiveValue: {print($0)})
}

// tryFirst(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/tryfirst(where:)
func tryFirstWhere() {
    struct RangeError: Error {}
    let numberRange: ClosedRange<Int> = (-1...50)
    numberRange.publisher
        .tryFirst(where: {
            guard $0 < 99 else { throw RangeError() }
            return true
        })
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

// last() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/last()
func last() {
    let numbers = (-10...10)
    let cancellable = numbers.publisher
        .last()
        .sink(receiveValue: {print($0)})
}

// last(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/last(where:)
func lastWhere() {
    let numbers = (-10...10)
    let cancellable = numbers.publisher
        .last(where: { $0 < 6 })
        .sink(receiveValue: {print($0)})
}

// tryLast(where:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trylast(where:)
func tryLastWhere() {
    struct RangeError: Error {}
    let numbers = [-62, 1, 6, 10, 9, 22, 41, -1, 5]
    let cancellable = numbers.publisher
        .tryLast(where: {
            guard $0 != 0 else { throw RangeError() }
            return true
        })
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

// output(at:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/output(at:)
func outputAt() {
    let numbers = (1...10)
    numbers.publisher
        .output(at: 5)
        .sink(receiveValue: {print($0)})
}

// output(in:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/output(in:)
func outputIn() {
    let numbers = [1,1,2,2,2,3,4,5,6]
    numbers.publisher
        .output(in: (3...5))
        .sink(receiveValue: {print($0)})
}

// combineLatest(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/combinelatest(_:_:)-1n30g
func combineLatest() {
    let pub1 = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub1
        .combineLatest(pub2, { first, second in
            return first * second
        })
        .sink(receiveValue: {print($0)})
    
    pub1.send(1)
    pub1.send(2)
    pub2.send(2)
    pub1.send(9)
    pub1.send(3)
    pub2.send(12)
    pub1.send(13)
}
