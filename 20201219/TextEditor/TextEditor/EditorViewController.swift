//
//  EditorViewController.swift
//  TextEditor
//
//  Created by akio0911 on 2020/12/19.
//

import UIKit

final class EditorViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    
    private let editorModel = EditorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editorModel.delegate = self
    }
    
    @IBAction func clear(_ sender: Any) {
        editorModel.clear()
    }
    
    @IBAction func undo(_ sender: Any) {
        editorModel.undo()
    }
}

extension EditorViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        editorModel.textDidChange(text: textView.text ?? "")
    }
}

extension EditorViewController: EditorModelDelegate {
    func changeTextView(text: String) {
        textView.text = text
    }
}
