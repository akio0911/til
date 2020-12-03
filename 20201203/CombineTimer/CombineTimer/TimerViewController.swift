//
//  TimerViewController.swift
//  CombineTimer
//
//  Created by akio0911 on 2020/12/03.
//

import UIKit
import Combine

class TimerViewController: UIViewController {

    @IBOutlet private weak var secondsLabel: UILabel!
    
    private var viewModel: TimerViewModelType!
    private var cancelables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        bindViewModel()
    }

    @IBAction func reset(_ sender: Any) {
        viewModel.input.tappedResetButton()
    }
    
    @IBAction func start(_ sender: Any) {
        viewModel.input.tappedStartButton()
    }
    
    @IBAction func pause(_ sender: Any) {
        viewModel.input.tappedPauseButton()
    }
    
    private func configureNavigation() {
        navigationItem.title = "タイマー"
    }
    
    private func bindViewModel() {
        let viewModel = TimerViewModel()
        self.viewModel = viewModel
        
        viewModel.currentSecondsPublisher
            .assign(to: \.text, on: secondsLabel)
            .store(in: &cancelables)
    }
}

