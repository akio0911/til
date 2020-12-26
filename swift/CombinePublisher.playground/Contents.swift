import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


// assign(to:on:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/assign(to:on:)

//class MyClass {
//    var anInt: Int = 0 {
//        didSet {
//            print("anInt was set to: \(anInt)")
//        }
//    }
//}
//
//var myObject = MyClass()
//let myRange = (0...2)
//let cancellable = myRange.publisher
//    .assign(to: \.anInt, on: myObject)


// assign(to:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/assign(to:)

//class MyModel: ObservableObject {
//    @Published var lastUpdated: Date = Date()
//
//    init() {
//        Timer.publish(every: 1.0, on: .main, in: .common)
//            .autoconnect()
//            .assign(to: &$lastUpdated)
//    }
//}
//
//let model = MyModel()
//let cancellable = model.$lastUpdated.sink(receiveValue: {print($0)})

class MyModel2: ObservableObject {
    @Published var id: Int = 0
}
let model2 = MyModel2()
Just(100).assign(to: &model2.$id)
