//
//  TimerModel.swift
//  CombineTimer
//
//  Created by akio0911 on 2020/12/03.
//

import Foundation
import Combine

final class TimerModel {
    private let countSubject: CurrentValueSubject<Int, Never>
    private let isValidSubject: PassthroughSubject<Bool, Never>
    private var cencelables = Set<AnyCancellable>()
    
    var countPublisher: AnyPublisher<Int, Never>
    
    init(interval: TimeInterval = 1.0) {
        let countSubject = CurrentValueSubject<Int, Never>(0)
        self.countSubject = countSubject
        self.countPublisher = countSubject.eraseToAnyPublisher()
        
        let isValidSubject = PassthroughSubject<Bool, Never>()
        self.isValidSubject = isValidSubject
        
        isValidSubject
            .flatMapLatest({ isValid in
                isValid ? Timer.publish(every: interval, on: .main, in: .default).autoconnect().eraseToAnyPublisher() : Empty<Date, Never>(completeImmediately: true).eraseToAnyPublisher()
            })
            .sink { _ in
                countSubject.send(countSubject.value + 1)
            }
            .store(in: &cencelables)
    }
    
    func pauseTimer() {
        isValidSubject.send(false)
    }
    
    func resetTimer() {
        countSubject.send(0)
    }
    
    func startTimer() {
        isValidSubject.send(true)
    }
}
