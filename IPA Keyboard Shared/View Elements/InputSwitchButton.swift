//
//  InputSwitchButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import UIKit

struct InputSwitchButton: UIViewRepresentable {
    var inputViewController: UIInputViewController?

    func makeUIView(context: Context) -> UIButton {
        let nextKeyboardButton = UIButton(type: .system)
        nextKeyboardButton.setTitle(NSLocalizedString("ABC", tableName: "Localizable", comment: "Switch keyboards"), for: [])
        
        nextKeyboardButton.titleLabel?.font = nextKeyboardButton.titleLabel!.font.withSize(18)
        nextKeyboardButton.backgroundColor = UIColor(white: 0, alpha: 0.001) // To fix touch hittest area
        
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.frame.size.width = 10
        nextKeyboardButton.frame.size.height = 20
        
        if let inputController = inputViewController {
            nextKeyboardButton.addTarget(self, action: #selector(inputController.handleInputModeList(from:with:)), for: .allEvents)
        }
        return nextKeyboardButton
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        
    }
}
