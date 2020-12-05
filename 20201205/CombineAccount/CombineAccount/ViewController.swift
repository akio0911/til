//
//  ViewController.swift
//  CombineAccount
//
//  Created by akio0911 on 2020/12/05.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet private weak var userTextField: UITextField!
    @IBOutlet private weak var password1TextField: UITextField!
    @IBOutlet private weak var password2TextField: UITextField!
    @IBOutlet private weak var createButton: UIButton!
    
    @Published private var user: String = ""
    @Published private var password1: String = ""
    @Published private var password2: String = ""

    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    @IBAction func didChangeUser(_ sender: UITextField) {
        user = sender.text ?? ""
    }
    
    @IBAction func didChangePassword1(_ sender: UITextField) {
        password1 = sender.text ?? ""
    }

    @IBAction func didChangePassword2(_ sender: UITextField) {
        password2 = sender.text ?? ""
    }

    private func setupBindings() {
        let isValidUser = $user
            .map { 8 <= $0.count }
        
        let isValidPassword = $password1
            .combineLatest($password2)
            .map { password1, password2 in
                password1.count >= 8 && password2.count >= 8 && password1 == password2
            }
        
        isValidUser
            .combineLatest(isValidPassword)
            .map { $0 && $1 }
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: createButton)
            .store(in: &cancellables)
    }
}
