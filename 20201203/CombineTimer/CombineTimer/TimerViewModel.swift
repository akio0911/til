//
//  TimerViewModel.swift
//  CombineTimer
//
//  Created by akio0911 on 2020/12/03.
//

import Foundation
import Combine

protocol TimerViewModelInput {
    func tappedPauseButton()
    func tappedResetButton()
    func tappedStartButton()
}

protocol TimerViewModelOutput {
    var currentSecondsPublisher: AnyPublisher<String?, Never> { get }
}

protocol TimerViewModelType {
    var input: TimerViewModelInput { get }
    var output: TimerViewModelOutput { get }
}

final class TimerViewModel: TimerViewModelType, TimerViewModelInput, TimerViewModelOutput {
    private let model: TimerModel
    
    var input: TimerViewModelInput { self }
    var output: TimerViewModelOutput { self }
    
    init(model: TimerModel = TimerModel()) {
        self.model = model
        self.currentSecondsPublisher = model.countPublisher
            .map { String(format: "%02d:%02i:%02i", $0 / 3600 % 60, $0 / 60 % 60, $0 % 60) }
            .eraseToAnyPublisher()
    }
    
    func tappedPauseButton() {
        model.pauseTimer()
    }
    
    func tappedResetButton() {
        model.resetTimer()
    }
    
    func tappedStartButton() {
        model.startTimer()
    }
    
    let currentSecondsPublisher: AnyPublisher<String?, Never>
}
