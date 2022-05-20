//
//  InputSwitchButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

extension UIKitComponents {
    static func inputSwitchButton() -> UIButton {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "globe"), for: [])
        button.tintColor = .label
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .clearInteractable
        
        let nextKeyboardButtonHorizontalInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 18 : 12
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: nextKeyboardButtonHorizontalInset, bottom: 12, right: nextKeyboardButtonHorizontalInset)
        
        return button
    }
}
