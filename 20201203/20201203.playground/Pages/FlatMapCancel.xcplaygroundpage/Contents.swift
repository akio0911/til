//: [Previous](@previous)

import Foundation
import Combine

let publisher = PassthroughSubject<Int, Never>()

let cancellable = publisher
    .handleEvents(receiveCancel: {
        print("receive cancel")
    })
    .flatMap({ _ in
        Just(-1)
    })
    .sink(receiveCompletion: {
        print($0)
    }, receiveValue: {
        print($0)
    })

publisher.send(1)
publisher.send(2)

cancellable.cancel()

publisher.send(3)




//: [Next](@next)
