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
        
        let horizontalInset: Double = UIDevice.current.userInterfaceIdiom == .pad ? 32 : Layout.leftInsetRaw
        let verticalInset: Double = 12
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        button.imageView!.widthAnchor.constraint(equalToConstant: BottomRow.rowHeight - 2 * verticalInset).isActive = true
        button.widthAnchor.constraint(equalTo: button.imageView!.widthAnchor, constant: horizontalInset * 2).isActive = true
        
        return button
    }
}
