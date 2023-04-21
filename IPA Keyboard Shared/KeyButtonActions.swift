//
//  KeyButtonActions.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/24/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

extension MasterKeyboardViewController {
    
    func initializeKeyButton(_ cell: KeyButtonCell) {
        let button = cell.button
        
        if cell.requestToInitializeAction() {
            // Will only run if targets have not been added
            // Add targets
            button.addTarget(self, action: #selector(insertKeyButtonText(from:with:)), for: .primaryActionTriggered)
            button.addTarget(self, action: #selector(keyButtonExpand(from:with:)), for: .touchDown)
            
            // Add retraction targets
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchCancel)
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpOutside)
            button.addTarget(self, action: #selector(keyButtonRetract(from:with:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Button Actions
    
    @objc func keyButtonExpand(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            keyButtonCell.delegate.isPressed = true
            
            let originalRect = keyCollection.convert(keyButtonCell.frame, to: expandedKeyOverlay.superview)
            
            expandedKeyOverlay.show(
                title: keyButtonCell.delegate.title,
                frame: CGRect(x: originalRect.midX, y: originalRect.midY, width: originalRect.width, height: originalRect.height)
            )
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
    @objc func keyButtonRetract(from button: UIButton, with event: UIEvent) {
        if let keyButtonCell = button.superview?.superview as? KeyButtonCell {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] _ in
                keyButtonCell.delegate.isPressed = false
                self?.expandedKeyOverlay.hide()
            }
        } else {
            fatalError("Incorrect button setup.")
        }
    }
    
    @objc func insertKeyButtonText(from button: UIButton, with event: UIEvent) {
        guard let text = (button.superview?.superview as? KeyButtonCell)?.delegate.title else {
            return
        }
        textDocumentProxy.insertText(Symbols.removedDottedCircles(text))
    }
}
