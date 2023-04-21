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
        textDocumentProxy.insertText(text)
    }
    
    func moveCursorBackByOne() {
        textDocumentProxy.adjustTextPosition(byCharacterOffset: -1)
    }

    func moveCursorForwardByOne() {
        textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
    }
    
    func deleteBackwardByOne() {
        textDocumentProxy.deleteBackward()
    }
}
