//
//  ViewController.swift
//  CombineCalculator
//
//  Created by akio0911 on 2021/01/16.
//

import UIKit
import Combine

final class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var textField3: UITextField!
    
    @IBOutlet private weak var button: UIButton!
    
    @IBOutlet private weak var resultLabel: UILabel!
    
    private let viewModel = ViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
    }

    private func setupBindings() {
        viewModel.textField1BackgroundColor
            .receive(on: DispatchQueue.main)
            .assign(to: \UITextField.backgroundColor, on: textField1)
            .store(in: &cancellables)
        
        viewModel.textField2BackgroundColor
            .receive(on: DispatchQueue.main)
            .assign(to: \UITextField.backgroundColor, on: textField2)
            .store(in: &cancellables)
        
        viewModel.textField3BackgroundColor
            .receive(on: DispatchQueue.main)
            .assign(to: \UITextField.backgroundColor, on: textField3)
            .store(in: &cancellables)
        
        viewModel.resultText
            .receive(on: DispatchQueue.main)
            .assign(to: \UILabel.text, on: resultLabel)
            .store(in: &cancellables)
    }
    
    @IBAction private func calculate(_ sender: Any) {
        viewModel.calculate(
            text1: textField1.text,
            text2: textField2.text,
            text3: textField3.text
        )
    }
}

final class ViewModel {
    var textField1BackgroundColor: AnyPublisher<UIColor?, Never> {
        textField1BackgroundColorSubject.eraseToAnyPublisher()
    }
    private let textField1BackgroundColorSubject = CurrentValueSubject<UIColor?, Never>(.white)
    
    var textField2BackgroundColor: AnyPublisher<UIColor?, Never> {
        textField2BackgroundColorSubject.eraseToAnyPublisher()
    }
    private let textField2BackgroundColorSubject = CurrentValueSubject<UIColor?, Never>(.white)
    
    var textField3BackgroundColor: AnyPublisher<UIColor?, Never> {
        textField3BackgroundColorSubject.eraseToAnyPublisher()
    }
    private let textField3BackgroundColorSubject = CurrentValueSubject<UIColor?, Never>(.white)
    
    var resultText: AnyPublisher<String?, Never> {
        resultTextSubject.eraseToAnyPublisher()
    }
    private let resultTextSubject = CurrentValueSubject<String?, Never>("")
    
    func calculate(text1: String?, text2: String?, text3: String?) {
        let optNum1 = text1.flatMap { Int($0) }
        let optNum2 = text2.flatMap { Int($0) }
        let optNum3 = text3.flatMap { Int($0) }

        guard let num1 = optNum1,
              let num2 = optNum2,
              let num3 = optNum3 else {
            
            func check(optNum: Int?, subject: CurrentValueSubject<UIColor?, Never>) {
                if optNum == nil {
                    subject.send(.red)
                    DispatchQueue.main.asyncAfter(
                        deadline: .now() + .milliseconds(500),
                        execute: {
                            subject.send(.white)
                        }
                    )
                }
            }
            
            check(optNum: optNum1, subject: textField1BackgroundColorSubject)
            check(optNum: optNum2, subject: textField2BackgroundColorSubject)
            check(optNum: optNum3, subject: textField3BackgroundColorSubject)

            return
        }
        
        resultTextSubject.send("\(num1 * num2 + num3)")
    }
}
