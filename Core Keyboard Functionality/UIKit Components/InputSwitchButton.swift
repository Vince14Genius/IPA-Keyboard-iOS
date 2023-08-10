//
//  InputSwitchButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

@objc class InputSwitchButton: NSObject {
    private var widthConstraints = [NSLayoutConstraint]()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "globe"), for: [])
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.3), for: .highlighted)
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .clearInteractable
        
        return button
    }()
    
    override init() {
        super.init()
        button.addTarget(self, action: #selector(buttonPress(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonUnpress(_:)), for: [.touchCancel, .primaryActionTriggered, .touchUpInside, .touchUpOutside])
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        sender.backgroundColor = .init(white: 1.0, alpha: 0.4)
    }
    
    @IBAction func buttonUnpress(_ sender: UIButton) {
        sender.backgroundColor = .clearInteractable
    }
    
    func updateInsets(inputViewController: UIInputViewController) {
        let sizeClass: UserInterfaceSizeClass
        switch inputViewController.traitCollection.horizontalSizeClass {
        case .compact: sizeClass = .compact
        case .regular: sizeClass = .regular
        case .unspecified: sizeClass = .compact
        @unknown default: sizeClass = .compact
        }
        
        let keyboardSizeClass = KeyboardSizeClass.from(
            sizeClass: sizeClass,
            rootViewController: inputViewController,
            needsInputModeSwitchKey: inputViewController.needsInputModeSwitchKey
        )
        
        print("Calculated KeyboardSizeClass.from() in InputSwitchButton.updateInsets(inputViewController:)\nreturning KeyboardSizeClass value: \(keyboardSizeClass.rawValue)")
        
        let horizontalInset: Double
        let verticalInset: Double
        
        switch sizeClass {
        case .compact:
            horizontalInset = UIDevice.current.userInterfaceIdiom == .pad ? 0 : Layout.leftInsetRaw
            verticalInset = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 6
        case .regular:
            horizontalInset = 32
            verticalInset = 8
        @unknown default:
            horizontalInset = Layout.leftInsetRaw
            verticalInset = 6
        }
        
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        let glyphSideLength = BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass) - 2 * verticalInset
        
//        button.clipsToBounds = true
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.sizeToFit()
        
        widthConstraints.forEach { $0.isActive = false }
        widthConstraints = [
            button.imageView!.widthAnchor.constraint(equalToConstant: glyphSideLength),
            button.imageView!.heightAnchor.constraint(equalTo: button.imageView!.widthAnchor),
            button.imageView!.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            button.imageView!.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            button.widthAnchor.constraint(equalTo: button.imageView!.widthAnchor, constant: horizontalInset * 2),
        ]
        widthConstraints.forEach { $0.isActive = true }
        
        print("""
        Called InputSwitchButton.updateInsets(inputViewController:)
          glyphSideLength: \(glyphSideLength)
          horizontalInset: \(horizontalInset)
          verticalInset: \(verticalInset)
        """)
    }
}
