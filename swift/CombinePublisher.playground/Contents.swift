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

//class MyModel2: ObservableObject {
//    @Published var id: Int = 0
//}
//let model2 = MyModel2()
//Just(100).assign(to: &model2.$id)


// sink(receiveCompletion:receiveValue:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:)

//let myRange = (0...3)
//let cancellable = myRange.publisher
//    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})


// sink(receiveValue:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/sink(receivevalue:)

//let integers = (0...3)
//integers.publisher
//    .sink(receiveValue: {print($0)})


// breakpoint(receiveSubscription:receiveOutput:receiveCompletion:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/breakpoint(receivesubscription:receiveoutput:receivecompletion:)

//let publisher = PassthroughSubject<String?, Never>()
//let cancellable = publisher
//    .breakpoint(receiveOutput: { value in return value == "DEBUGGER" })
//    .sink(receiveValue: {print($0)})
//
//publisher.send("DEBUGGER")


// breakpointOnError() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/breakpointonerror()

//struct CustomError: Error {}
//let publisher = PassthroughSubject<String?, Error>()
//let cancellable = publisher
//    .tryMap({ stringValue in
//        throw CustomError()
//    })
//    .breakpointOnError()
//    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
//
//publisher.send("TEST DATA")


// handleEvents(receiveSubscription:receiveOutput:receiveCompletion:receiveCancel:receiveRequest:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/handleevents(receivesubscription:receiveoutput:receivecompletion:receivecancel:receiverequest:)

//let integers = (0...2)
//let cancellable =
//    integers.publisher
//    .handleEvents(receiveSubscription: {print($0)},
//                  receiveOutput: {print($0)},
//                  receiveCompletion: {print($0)},
//                  receiveCancel: {print("receiveCancel")},
//                  receiveRequest: {print($0)})
//        .sink(receiveValue: { _ in })
