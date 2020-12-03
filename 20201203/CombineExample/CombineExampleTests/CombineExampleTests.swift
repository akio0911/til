//
//  CombineExampleTests.swift
//  CombineExampleTests
//
//  Created by akio0911 on 2020/12/03.
//

import XCTest
import Combine
@testable import CombineExample

class MapErrorTests: XCTestCase {
    enum ExampleError: Error { case example }
    enum OtherError: Error { case example }
    
    func testエラーを他のエラーにして異常終了() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 1

        let publisher = Fail(
            outputType: Void.self,
            failure: ExampleError.example
        )
        
        let _ = publisher
            .mapError({ error -> OtherError in
                OtherError.example
            })
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    XCTFail("正常終了してしまった")
                case .failure(let error):
                    XCTAssertEqual(error, OtherError.example)
                    sink.fulfill()
                }
            }, receiveValue: {
                XCTFail("値を受け取ってはいけない")
            })
        
        wait(for: [sink], timeout: 0.01)
    }
}

class CatchTests: XCTestCase {
    enum ExampleError: Error { case example }

    func testエラーを置き換える() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 2
        
        let publisher = Fail(
            outputType: String.self,
            failure: ExampleError.example
        )

        let _ = publisher
            .catch { _ in
                Just("X")
            }
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    sink.fulfill()
                case .failure:
                    XCTFail("エラーが流れてしまい異常終了")
                }
            }, receiveValue: {
                XCTAssertEqual($0, "X")
                sink.fulfill()
            })
        
        wait(for: [sink], timeout: 0.01)
    }
    
    func testリトライと組み合わせる() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 1
        
        var temp: [Int] = []
        
        let _ = (1..<100).publisher
            .tryMap({ (arg: Int) -> Int in
                if arg == 3 {
                    throw ExampleError.example
                }
                return arg
            })
            .retry(1)
            .catch({ error -> AnyPublisher<Int, Never> in
                print(error)
                return Just(0).eraseToAnyPublisher()
            })
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    sink.fulfill()
                case .failure:
                    XCTFail("エラーが流れてしまい異常終了n")
                }
            }, receiveValue: {
                temp.append($0)
            })

        XCTAssertEqual(temp, [1,2,1,2,0])
        wait(for: [sink], timeout: 0.01)
    }
}

class ReplaceErrorTests: XCTestCase {
    enum ExampleError: Error { case example }
    
    func testエラーを置き換える() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 2
        
        let publisher = Fail(
            outputType: String.self,
            failure: ExampleError.example
        )
        
        let _ = publisher
            .replaceError(with: "X")
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    sink.fulfill()
                case .failure:
                    XCTFail("エラーが流れてしまい異常終了")
                }
            }, receiveValue: {
                XCTAssertEqual($0, "X")
                sink.fulfill()
            })
        
        wait(for: [sink], timeout: 0.01)
    }
    
    func testリトライと組み合わせる() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 1
        
        var temp: [Int] = []
        
        let _ = (1..<100).publisher
            .tryMap({ (arg: Int) -> Int in
                if arg == 3 {
                    throw ExampleError.example
                }
                return arg
            })
            .retry(1)
            .replaceError(with: 0)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    sink.fulfill()
                case .failure:
                    XCTFail("エラーが流れてしまい異常終了")
                }
            }, receiveValue: {
                temp.append($0)
            })
        
        XCTAssertEqual(temp, [1,2,1,2,0])
        wait(for: [sink], timeout: 0.01)
    }
}

class RetryTests: XCTestCase {
    enum ExampleError: Error { case example }
    
    func testリトライによりエラーを流さない() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 2
        
        let subscription = expectation(description: "")
        subscription.expectedFulfillmentCount = 2
        
        var isFirstTry = true
        
        let _ = "A".publisher
            .handleEvents(receiveSubscription: { aValue in
                subscription.fulfill()
            })
            .tryMap { (arg: Character) -> Character in
                if isFirstTry {
                    isFirstTry = false
                    throw ExampleError.example
                }
                return arg
            }
            .retry(1)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    sink.fulfill()
                case .failure:
                    XCTFail("エラーが流れ異常終了してしまった")
                }
            }, receiveValue: {
                XCTAssertEqual($0, "A")
                sink.fulfill()
            })
            
        wait(for: [sink, subscription], timeout: 0.01)
    }
}

class TryMapTests: XCTestCase {
    enum ExampleError: Error { case example }
    
    func test() {
        let sink = expectation(description: "")
        sink.expectedFulfillmentCount = 1
        
        var temp: [Int] = []
        
        let _ = (1..<100).publisher
            .tryMap({ (arg: Int) -> Int in
                if arg == 3 {
                    throw ExampleError.example
                }
                return arg
            })
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    XCTFail("エラーが流れず正常終了してしまった")
                case .failure(let error):
                    XCTAssertEqual(error as? ExampleError, ExampleError.example)
                    sink.fulfill()
                }
            }, receiveValue: {
                temp.append($0)
            })
        
        XCTAssertEqual(temp, [1, 2])
        wait(for: [sink], timeout: 0.01)
    }
}

class FailTests: XCTestCase {

    enum ExampleError: Error {
        case example
    }
    
    func test() {
        let sink = expectation(description: "")
        
        let publisher = Fail(outputType: Void.self, failure: ExampleError.example)
        
        let _ = publisher.sink(receiveCompletion: {
            switch $0 {
            case .finished:
                XCTFail("エラーが流れなかった")
            case .failure(let error):
                XCTAssertEqual(error, ExampleError.example)
                sink.fulfill()
            }
        }, receiveValue: { _ in
            XCTFail("値が流れてしまった")
        })
        
        wait(for: [sink], timeout: 0.01)
    }
}

