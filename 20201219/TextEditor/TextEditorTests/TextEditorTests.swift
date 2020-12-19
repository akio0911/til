//
//  TextEditorTests.swift
//  TextEditorTests
//
//  Created by akio0911 on 2020/12/19.
//

import XCTest
@testable import TextEditor

private class Delegate: EditorModelDelegate {
    private var textViewへの表示要求: [String] = []
    
    var textViewへの最後の表示要求: String? {
        textViewへの表示要求.last
    }
    
    func changeTextView(text: String) {
        textViewへの表示要求.append(text)
    }
}

class TextEditorTests: XCTestCase {
    
    func test_undoのテスト() throws {
        let editorModel = EditorModel()
        
        let delegate = Delegate()
        editorModel.delegate = delegate
        
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "H")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "He")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hel")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hell")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hello")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "Hell")
        
        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "Hel")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "He")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "H")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "")
    }
    
    func test_clearのテスト() throws {
        let editorModel = EditorModel()
        
        let delegate = Delegate()
        editorModel.delegate = delegate
        
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "H")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "He")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hel")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hell")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.textDidChange(text: "Hello")
        XCTAssertEqual(delegate.textViewへの最後の表示要求, nil)
        
        editorModel.clear()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "Hello")
        
        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "Hell")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "Hel")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "He")

        editorModel.undo()
        XCTAssertEqual(delegate.textViewへの最後の表示要求, "H")
    }
}
