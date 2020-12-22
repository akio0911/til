import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


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

// zip(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/zip(_:)
func zipP() {
    let numbersPub = PassthroughSubject<Int, Never>()
    let lettersPub = PassthroughSubject<String, Never>()
    
    let cancellable = numbersPub
        .zip(lettersPub)
        .sink(receiveValue: {print($0)})
    
    numbersPub.send(1)
    numbersPub.send(2)
    lettersPub.send("A")
    numbersPub.send(3)
    lettersPub.send("B")
}

// zip(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/zip(_:_:)-4xn21
func zipPT() {
    let numbersPub = PassthroughSubject<Int, Never>()
    let lettersPub = PassthroughSubject<String, Never>()
    
    let cancellable = numbersPub
        .zip(lettersPub, { anInt, aLetter in
            String(repeating: aLetter, count: anInt)
        })
        .sink(receiveValue: {print($0)})
    
    numbersPub.send(1)
    numbersPub.send(2)
    numbersPub.send(3)
    lettersPub.send("A")
    lettersPub.send("B")
}

// zip(_:_:_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/zip(_:_:_:_:)
func zipPQRT() {
    let numbersPub = PassthroughSubject<Int, Never>()
    let lettersPub = PassthroughSubject<String, Never>()
    let emojiPub = PassthroughSubject<String, Never>()
    let fractionsPub = PassthroughSubject<Double, Never>()
    
    let cancellable = numbersPub
        .zip(lettersPub, emojiPub, fractionsPub, { anInt, aLetter, anEmoji, aFraction in
            ("\(String(repeating: anEmoji, count: anInt)) \(String(repeating: aLetter, count: anInt)) \(aFraction)")
        })
        .sink(receiveValue: {print($0)})
    
    numbersPub.send(1)
    numbersPub.send(2)
    numbersPub.send(3)
    fractionsPub.send(0.1)
    lettersPub.send("A")
    emojiPub.send("😀")
    lettersPub.send("B")
    fractionsPub.send(0.8)
    emojiPub.send("🥰")
}

// assertNoFailure(_:file:line:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/assertnofailure(_:file:line:)
func assertNoFailure() {
    enum SubjectError: Error {
        case genericSubjectError
    }
    
    let subject = CurrentValueSubject<String, Error>("initial value")
    subject
        .assertNoFailure()
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
    
    subject.send("second value")
    subject.send(completion: Subscribers.Completion<Error>.failure(SubjectError.genericSubjectError))
}

// catch(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/catch(_:)
func catchHandler() {
    struct SimpleError: Error {}
    let numbers = [5,4,3,2,1,0,9,8,7,6]
    let cancellable = numbers.publisher
        .tryLast(where: {
            guard $0 != 0 else { throw SimpleError() }
            return true
        })
        .catch({ error in
            Just(-1)
        })
        .sink(receiveValue: {print($0)})
}

// tryCatch(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/trycatch(_:)
func tryCatch() {
    enum SimpleError: Error { case error }
    let numbers = [5,4,3,2,1,-1,7,8,9,10]
    
    let cancellable = numbers.publisher
        .tryMap({ v in
            if v > 0 {
                return v
            } else {
                throw SimpleError.error
            }
        })
        .tryCatch({ error in
            Just(0)
        })
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

// retry(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/retry(_:)
func retry() -> AnyCancellable {
    struct WebSiteData: Codable {
        var rawHTML: String
    }
    
    let myURL = URL(string: "https://www.example.comZZZ")
    return URLSession.shared.dataTaskPublisher(for: myURL!)
        .retry(3)
        .map({ page -> WebSiteData in
            return WebSiteData(rawHTML: String(decoding: page.data, as: UTF8.self))
        })
        .catch({ _ in
            return Just(WebSiteData(rawHTML: "<HTML>Unable to load page - timed out.</HTML>"))
        })
        .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
}

// flatMap(maxPublishers:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/flatmap(maxpublishers:_:)-3k7z5

func flatMapTP() {
    struct WeatherStation {
        let stationID: String
    }
    
    func fetch(station: WeatherStation) -> AnyPublisher<Data, URLError> {
        Just(Data()).setFailureType(to: URLError.self).eraseToAnyPublisher()
    }
    
    let weatherPublisher = PassthroughSubject<WeatherStation, URLError>()
    
    let cancellable = weatherPublisher.flatMap { station -> AnyPublisher<Data, URLError> in
//        let url = URL(string:"https://weatherapi.example.com/stations/\(station.stationID)/observations/latest")!
//        return URLSession.shared.dataTaskPublisher(for: url)
        fetch(station: station)
    }
    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
    
    weatherPublisher.send(WeatherStation(stationID: "KSFO"))
    weatherPublisher.send(WeatherStation(stationID: "EGLC"))
    weatherPublisher.send(WeatherStation(stationID: "ZBBB"))
}

func switchToLatest() -> Set<AnyCancellable>{
    var cancellables = Set<AnyCancellable>()
    let subject = PassthroughSubject<Int, Never>()
    subject
        .setFailureType(to: URLError.self)
        .map({ index -> URLSession.DataTaskPublisher in
            let url = URL(string: "https://www.google.com?q=\(index)")!
            return URLSession.shared.dataTaskPublisher(for: url)
        })
        .switchToLatest()
        .sink(receiveCompletion: {print($0)}, receiveValue: {
                print($0.response.url)
        })
        .store(in: &cancellables)
    
    (1...5).forEach({ index in
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(index*100), execute: {
            subject.send(index)
        })
    })
    
    return cancellables
}

// measureInterval(using:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/measureinterval(using:options:)

//let cancellable = Timer.publish(every: 1, on: .main, in: .default)
//    .autoconnect()
//    .measureInterval(using: RunLoop.main)
//    .sink(receiveValue: {print($0)})


// debounce(for:scheduler:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/debounce(for:scheduler:options:)

//let bounces: [(Int, TimeInterval)] = [
//    (0, 0),
//    (1, 0.25),
//    (2, 1),
//    (3, 1.25),
//    (4, 1.5),
//    (5, 2)
//]
//
//let subject = PassthroughSubject<Int, Never>()
//let cancellable = subject
//    .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
//    .sink(receiveValue: {print($0)})
//
//bounces.forEach({ bounce in
//    DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1, execute: {
//        subject.send(bounce.0)
//    })
//})


// delay(for:tolerance:scheduler:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/delay(for:tolerance:scheduler:options:)

//let df = DateFormatter()
//df.dateStyle = .none
//df.timeStyle = .long
//let cancellable = Timer.publish(every: 1.0, on: .main, in: .default)
//    .autoconnect()
//    .handleEvents(receiveOutput: { date in
//        print("Sending Timestamp: \(df.string(from: date))")
//    })
//    .delay(for: .seconds(3), scheduler: RunLoop.main, options: .none)
//    .sink(receiveCompletion: {print($0)}, receiveValue: {
//        let now = Date()
//        print("At: \(df.string(from: now)), Received: \(df.string(from: $0))")
//    })


// throttle(for:scheduler:latest:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/throttle(for:scheduler:latest:)

//let cancellable = Timer.publish(every: 3.0, on: .main, in: .default)
//    .autoconnect()
//    .print("\(Date().description)")
//    .throttle(for: 10.0, scheduler: RunLoop.main, latest: true)
//    .sink(receiveCompletion: {print($0)}, receiveValue: {
//        print("Received Timestamp \($0)")
//    })


// timeout(_:scheduler:options:customError:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/timeout(_:scheduler:options:customerror:)

//let WAIT_TIME = 2
//let TIMEOUT_TIME = 5
//
//let subject = PassthroughSubject<String, Never>()
//let cancellable = subject
//    .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError: nil)
//    .sink(receiveCompletion: { print($0) }, receiveValue: { print("value: \($0) at \(Date())") })
//
//DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(WAIT_TIME), execute: {
//    subject.send("sent after a delay of \(WAIT_TIME) seconds")
//})


// decode(type:decoder:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/decode(type:decoder:)

//struct Article: Codable {
//    let title: String
//    let author: String
//    let pubDate: Date
//}
//
//let dataProvider = PassthroughSubject<Data, Never>()
//let cancellable = dataProvider
//    .decode(type: Article.self, decoder: JSONDecoder())
//    .sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})
//
//dataProvider.send(Data("{\"pubDate\":1574273638.575666, \"title\" : \"My First Article\", \"author\" : \"Gita Kumar\" }".utf8))


// encode(encoder:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/encode(encoder:)

//struct Article: Codable {
//    let title: String
//    let author: String
//    let pubDate: Date
//}
//
//let dataProvider = PassthroughSubject<Article, Never>()
//let cancellable = dataProvider
//    .encode(encoder: JSONEncoder())
//    .sink(receiveCompletion: {print($0)}, receiveValue: { data in
//        guard let string = String(data: data, encoding: .utf8) else { return }
//        print(data, string)
//    })
//
//dataProvider.send(Article(title: "My First Article", author: "Gita Kumar", pubDate: Date()))


// map(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/map(_:)-6sm0a

//struct DiceRoll {
//    let die: Int
//}
//
//let cancellable = Just(DiceRoll(die: Int.random(in: 1...6)))
//    .map(\.die)
//    .sink(receiveValue: {print($0)})


// map(_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/map(_:_:)

//struct DiceRoll {
//    let die1: Int
//    let die2: Int
//}
//
//let cancellable = Just(DiceRoll(die1: Int.random(in: 1...6),
//                                die2: Int.random(in: 1...6)))
//    .map(\.die1, \.die2)
//    .sink(receiveValue: {print($0)})


// map(_:_:_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/map(_:_:_:)

//struct DiceRoll {
//    let die1: Int
//    let die2: Int
//    let die3: Int
//}
//
//let cancellable = Just(DiceRoll(die1: Int.random(in: 1...6),
//                                die2: Int.random(in: 1...6),
//                                die3: Int.random(in: 1...6)))
//    .map(\.die1, \.die2, \.die3)
//    .sink(receiveValue: {print($0)})


// multicast(_:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/multicast(_:)

//let pub = ["First", "Second", "Third"].publisher
//    .map { return ($0, Int.random(in: 0...100)) }
//    .print("Random")
//    .multicast({ PassthroughSubject<(String, Int), Never>() })
//
//let cancellable1 = pub
//    .sink { print("1: \($0)") }
//let cancellable2 = pub
//    .sink { print("2: \($0)") }
//pub.connect()


// multicast(subject:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/multicast(subject:)

//let pub = ["First", "Second", "Third"].publisher
//    .map { return ($0, Int.random(in: 0...100)) }
//    .print("Random")
//    .multicast(subject: PassthroughSubject<(String, Int), Never>())
//
//let cancellable1 = pub.sink(receiveValue: {print($0)})
//let cancellable2 = pub.sink(receiveValue: {print($0)})
//pub.connect()


// share() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/share()

//let pub = (1...3).publisher
//    .delay(for: 1, scheduler: DispatchQueue.main)
//    .map { _ in return Int.random(in: 0...100) }
//    .print("Random")
//    .share()
//
//let cancellable1 = pub
//    .sink(receiveValue: {print("1: \($0)")})
//
//let cancellable2 = pub
//    .sink(receiveValue: {print("2: \($0)")})


// buffer(size:prefetch:whenFull:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/buffer(size:prefetch:whenfull:)


// eraseToAnyPublisher() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/erasetoanypublisher()

//class TypeWithSubject {
//    let publisher = PassthroughSubject<Int,Never>()
//}
//
//class TypeWithErasedSubject {
//    let publisher = PassthroughSubject<Int,Never>().eraseToAnyPublisher()
//}
//
//let nonErased = TypeWithSubject()
//if let subject = nonErased.publisher as? PassthroughSubject<Int,Never> {
//    print("Successfully cast nonErased.publisher.")
//}
//let erased = TypeWithErasedSubject()
//if let subject = erased.publisher as? PassthroughSubject<Int,Never> {
//    print("Successfully cast erased.publisher.")
//}


// subscribe(on:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/subscribe(on:options:)

//let ioPerformingPublisher = (1...10).publisher
//let uiUpdatingSubscriver = PassthroughSubject<Int, Never>()
//
//let cancellable1 = uiUpdatingSubscriver.sink(receiveValue: {print($0)})
//
//let cancellable2 = ioPerformingPublisher
//    .subscribe(on: DispatchQueue.global())
//    .receive(on: RunLoop.main)
//    .subscribe(uiUpdatingSubscriver)


// receive(on:options:) | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/receive(on:options:)

//let jsonPublisher = PassthroughSubject<String, Never>()
//let labelUpdater = PassthroughSubject<String, Never>()
//
//let cancellable1 = labelUpdater.sink(receiveValue: {print($0)})
//
//let cancellable2 = jsonPublisher
//    .subscribe(on: DispatchQueue.global())
//    .receive(on: RunLoop.main)
//    .subscribe(labelUpdater)
//
//jsonPublisher.send("JSON1")
//jsonPublisher.send("JSON2")
//jsonPublisher.send("JSON3")


// makeConnectable() | Apple Developer Documentation
// https://developer.apple.com/documentation/combine/publisher/makeconnectable()

//let subject = Just<String>("Sent")
//let pub = subject
//    .share()
//    .makeConnectable()
//let cancellable1 = pub.sink { print("1: \($0)") }
//
//var cancellable2: AnyCancellable!
//DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//    cancellable2 = pub.sink { print("2: \($0)") }
//})
//var connectable: Any!
//DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//    connectable = pub.connect()
//})
