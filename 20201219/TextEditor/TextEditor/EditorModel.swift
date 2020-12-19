//
//  EditorModel.swift
//  TextEditor
//
//  Created by akio0911 on 2020/12/19.
//

import Foundation

protocol EditorModelDelegate: AnyObject {
    func changeTextView(text: String)
}

final class EditorModel {
    weak var delegate: EditorModelDelegate?

    private var currentText = ""
    private var textHistories: [String] = []
    
    func textDidChange(text: String) {
        textHistories.append(currentText)
        currentText = text
    }
    
    func clear() {
        textHistories.append(currentText)
        currentText = ""
        delegate?.changeTextView(text: "")
    }
    
    func undo() {
        guard !textHistories.isEmpty else { return }
        let last = textHistories.removeLast()
        currentText = last
        delegate?.changeTextView(text: last)
    }
}
