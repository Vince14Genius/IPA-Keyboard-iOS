//
//  UIInputViewController+.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import UIKit

extension UIInputViewController {
    func insertText(_ text: String) {
        self.textDocumentProxy.insertText(text)
    }
    
    func moveCursorBackByOne() {
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }

    func moveCursorForwardByOne() {
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
    }
    
    func deleteBackwardByOne() {
        self.textDocumentProxy.deleteBackward()
    }
}
