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

tryPrefixWhile()

