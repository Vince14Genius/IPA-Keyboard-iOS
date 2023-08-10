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
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        
        button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label.withAlphaComponent(0.3), for: .highlighted)
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .clearInteractable
        
        button.constraints.forEach { $0.isActive = false }
        button.imageView!.constraints.forEach { $0.isActive = false }
        
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
        
        switch keyboardSizeClass {
        case .padRegular:
            horizontalInset = 32
            verticalInset = 8
        case .fullCompact, .crowdedCompact, .padExtraCrowdedCompact:
            horizontalInset = Layout.leftInsetRaw
            verticalInset = 6
        }
        
        let glyphSideLength = BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass) - 2 * verticalInset
        
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.sizeToFit()
        
        widthConstraints.forEach { $0.isActive = false }
        let nonRequired = [
            button.imageView!.widthAnchor.constraint(equalToConstant: glyphSideLength),
            button.imageView!.heightAnchor.constraint(equalTo: button.imageView!.widthAnchor),
        ]
        nonRequired.forEach { $0.priority = .defaultHigh }
        widthConstraints = [
            button.widthAnchor.constraint(equalTo: button.imageView!.widthAnchor, constant: horizontalInset * 2),
            button.heightAnchor.constraint(equalToConstant: BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass)),
        ]
        widthConstraints.append(contentsOf: nonRequired)
        widthConstraints.forEach { $0.isActive = true }
        
        print("""
        Called InputSwitchButton.updateInsets(inputViewController:)
          glyphSideLength: \(glyphSideLength)
          horizontalInset: \(horizontalInset)
          verticalInset: \(verticalInset)
        INFO {
          view controller root view width: \(inputViewController.view.frame.width)
          real button insets: \(button.contentEdgeInsets)
        }
        """)
    }
}
