//
//  ViewController.swift
//  CombineCollect
//
//  Created by akio0911 on 2020/12/17.
//

import UIKit
import Combine

struct User {
    let id: Int
    let name: String
}

func delayedPublisher<Value>(_ value: Value, delay after: Double) -> AnyPublisher<Value, Never> {
    let p = PassthroughSubject<Value, Never>()
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        p.send(value)
        p.send(completion: .finished)
    }
    return p.eraseToAnyPublisher()
}

class ViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myPublishers = [1, 2, 3]
//            .map {
//                delayedPublisher($0, delay: 1 / Double($0))
//                    .print("\($0)")
//                    .eraseToAnyPublisher()
//            }
//
//        myPublishers
//            .publisher
//            .flatMap { $0 }
//            .collect()
//            .sink {
//                print("result: ", $0)
//            }
//            .store(in: &cancellables)
        
        let ids = [1, 2, 3]
        
        func fetch(userID: Int) -> AnyPublisher<User, Never> {
            print("####", "start", "\(userID)")
            let p = PassthroughSubject<User, Never>()

            let users = [
                User(id: 1, name: "sato"),
                User(id: 2, name: "suzuki"),
                User(id: 3, name: "tanaka"),
            ]

            switch userID {
            case 1:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    p.send(users[0])
                    p.send(completion: .finished)
                    print("####", "end", "\(userID)")
                }
            case 2:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    p.send(users[1])
                    p.send(completion: .finished)
                    print("####", "end", "\(userID)")
                }
            case 3:
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    p.send(users[2])
                    p.send(completion: .finished)
                    print("####", "end", "\(userID)")
                }
            default:
                fatalError()
            }

            return p.eraseToAnyPublisher()
        }

//        Publishers.MergeMany(ids.map({delayedPublisher($0, delay: 1 / Double($0))}))
//            .collect()
//            .sink {
//                print("result: ", $0)
//            }
//            .store(in: &cancellables)
        
//        func fetch(userID: Int) -> AnyPublisher<Int, Never> {
//            delayedPublisher(userID, delay: 1 / Double(userID))
//        }
//
//        Publishers
//            .MergeMany(
//                ids
//                    .enumerated()
//                    .map { index, element in
//                        fetch(userID: element).map { (index: index, element: $0) }
//                    }
//            )
//            .collect()
//            .sink {
//                print("result: ", $0.sorted(by: { $0.index < $1.index }).map { $0.element } )
//            }
//            .store(in: &cancellables)
        
//        let justs = (1...10).map {
//            Just($0)
//                .delay(for: .seconds(Int.random(in: 1...3)), scheduler: DispatchQueue.main)
//                .eraseToAnyPublisher()
//        }
        
//        print(justs.count)
//        let result: AnyPublisher<[Int], Never> = justs.dropFirst().reduce(into: AnyPublisher(justs[0].map{[$0]}), {
//            res, just in
//            res = res.zip(just) {
//                return $0 + [$1]
//            }.eraseToAnyPublisher()
//        })
//
//        result.sink { print($0) }.store(in: &cancellables)
        
//        let result = justs.reduce(into: Just<[Int]>([]).eraseToAnyPublisher(), {
//            res, just in
//            res = res.zip(just) {
//                $0 + [$1]
//            }.eraseToAnyPublisher()
//        })
//        result.sink { print($0) }.store(in: &cancellables)
        
//        ids
//            .map { fetch(userID: $0) }
//            .reduce(
//                into: Just<[User]>([]).eraseToAnyPublisher(),
//                { res, just in
//                    res = res.zip(just) { $0 + [$1] }.eraseToAnyPublisher()
//                }
//            )
//            .sink { print($0) }
//            .store(in: &cancellables)
        
        
        
        
//        Publishers.Sequence(sequence: ids.map { fetch(userID: $0) })
//            .flatMap { $0 }
//            .collect()
//            .receive(on: DispatchQueue.main)
//            .sink { print($0) }
//            .store(in: &cancellables)

//        struct OrderedValue<T> {
//            let order: Int
//            let value: T
//        }
//
//        Publishers
//            .Sequence(
//                sequence: ids.enumerated()
//                    .map { offset, id in
//                        fetch(userID: id)
//                            .map { OrderedValue(order: offset, value: $0) }
//                    }
//                )
//            .flatMap { $0 }
//            .collect()
//            .map { $0.sorted(by: { $0.order < $1.order }) }
//            .sink { print($0) }
//            .store(in: &cancellables)

        ids
            .map { fetch(userID: $0) }
            .reduceByZipping()
            .sink { print($0) }
            .store(in: &cancellables)

    }
}

extension Array where Element: Publisher {
    func reduceByZipping() -> AnyPublisher<[Element.Output], Element.Failure> {
        reduce(
            into: Just<[Element.Output]>([]).setFailureType(to: Element.Failure.self).eraseToAnyPublisher(),
            { res, just in
                res = res.zip(just) { $0 + [$1] }.eraseToAnyPublisher()
            }
        ).eraseToAnyPublisher()
    }
}
