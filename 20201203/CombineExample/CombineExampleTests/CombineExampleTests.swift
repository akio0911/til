//
//  CombineExampleTests.swift
//  CombineExampleTests
//
//  Created by akio0911 on 2020/12/03.
//

import XCTest
import Combine
@testable import CombineExample

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

