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

// combineLatest(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/combinelatest(_:)
func combineLatestOther() {
    let pub1 = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub1
        .combineLatest(pub2)
        .sink(receiveValue: {print($0)})
    
    pub1.send(1)
    pub1.send(2)
    pub2.send(2)
    pub1.send(3)
    pub1.send(45)
    pub2.send(22)
}

func combineLatest3Transform() {
    let pub = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    let pub3 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub
        .combineLatest(pub2, pub3, {
            return $0 * $1 * $2
        })
        .sink(receiveValue: {print($0)})
    
    pub.send(1)
    pub.send(2)
    pub2.send(2)
    pub3.send(10)
    
    pub.send(9)
    pub3.send(4)
    pub2.send(12)
}

func combineLatest3() {
    let pub = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    let pub3 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub
        .combineLatest(pub2, pub3)
        .sink(receiveValue: {print($0)})
    
    pub.send(1)
    pub.send(2)
    pub2.send(2)
    pub3.send(9)
    
    pub.send(3)
    pub2.send(12)
    pub.send(13)
    pub3.send(19)
}

func combineLatest4Transform() {
    let pub = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    let pub3 = PassthroughSubject<Int, Never>()
    let pub4 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub
        .combineLatest(pub2, pub3, pub4, {
            return $0 * $1 * $2 * $3
        })
        .sink(receiveValue: {print($0)})
    
    pub.send(1)
    pub.send(2)
    pub2.send(2)
    pub3.send(9)
    pub4.send(1)
    
    pub.send(3)
    pub2.send(12)
    pub.send(13)
    pub3.send(19)
}

func combineLatest4() {
    let pub = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    let pub3 = PassthroughSubject<Int, Never>()
    let pub4 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub
        .combineLatest(pub2, pub3, pub4)
        .sink(receiveValue: {print($0)})
    
    pub.send(1)
    pub.send(2)
    pub2.send(2)
    pub3.send(9)
    pub4.send(1)
    
    pub.send(3)
    pub2.send(12)
    pub.send(13)
    pub3.send(19)
}

// merge(with:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/merge(with:)-7qt71
func merge() {
    let pub = PassthroughSubject<Int, Never>()
    let pub2 = PassthroughSubject<Int, Never>()
    
    let cancellable = pub.merge(with: pub2)
        .sink(receiveValue: {print($0)})
    
    pub.send(1)
    pub.send(2)
    pub2.send(2)
    
    pub.send(3)
    pub2.send(12)
    pub.send(13)
}

// merge(with:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/merge(with:_:)
func merge3() {
    let pubA = PassthroughSubject<Int, Never>()
    let pubB = PassthroughSubject<Int, Never>()
    let pubC = PassthroughSubject<Int, Never>()
    
    let cancellable = pubA
        .merge(with: pubB, pubC)
        .sink(receiveValue: {print($0)})
    
    pubA.send(1)
    pubB.send(40)
    pubC.send(90)
    pubA.send(2)
    pubB.send(50)
    pubC.send(100)
}

// merge(with:_:_:_:_:_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/merge(with:_:_:_:_:_:_:)
func merge8() {
    let pubA = PassthroughSubject<Int, Never>()
    let pubB = PassthroughSubject<Int, Never>()
    let pubC = PassthroughSubject<Int, Never>()
    let pubD = PassthroughSubject<Int, Never>()
    let pubE = PassthroughSubject<Int, Never>()
    let pubF = PassthroughSubject<Int, Never>()
    let pubG = PassthroughSubject<Int, Never>()
    let pubH = PassthroughSubject<Int, Never>()
    
    let cancellable = pubA
        .merge(with: pubB, pubC, pubD, pubE, pubF, pubG, pubH)
        .sink(receiveValue: {print($0)})
    
    pubA.send(1)
    pubB.send(40)
    pubC.send(90)
    pubD.send(-1)
    pubE.send(33)
    pubF.send(44)
    pubG.send(54)
    pubH.send(1000)
    
    pubA.send(2)
    pubB.send(50)
    pubC.send(100)
    pubD.send(-2)
    pubE.send(33)
    pubF.send(33)
    pubG.send(54)
    pubH.send(1001)
}
