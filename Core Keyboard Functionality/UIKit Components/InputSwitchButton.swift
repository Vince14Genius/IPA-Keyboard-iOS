//
//  InputSwitchButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class InputSwitchButton: UIButton {
    private var widthConstraints = [NSLayoutConstraint]()
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage(systemName: "globe"), for: [])
        tintColor = .label
        
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clearInteractable
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateInsets(inputViewController: UIInputViewController) {
        let sizeClass: UserInterfaceSizeClass
        switch inputViewController.traitCollection.horizontalSizeClass {
        case .compact: sizeClass = .compact
        case .regular: sizeClass = .regular
        case .unspecified: sizeClass = .compact
        @unknown default: sizeClass = .compact
        }
        
        let rowsLayout = RowsLayout.from(
            sizeClass: sizeClass,
            inputViewController: inputViewController
        )
        
        let horizontalInset: Double
        let verticalInset: Double
        switch sizeClass {
        case .compact:
            horizontalInset = UIDevice.current.userInterfaceIdiom == .pad ? 4 : Layout.leftInsetRaw
            verticalInset = 12
        case .regular:
            horizontalInset = 32
            verticalInset = 4
        @unknown default:
            horizontalInset = Layout.leftInsetRaw
            verticalInset = 12
        }
        
        contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        widthConstraints.forEach { $0.isActive = false }
        widthConstraints = [
            imageView!.widthAnchor.constraint(equalToConstant: BottomRow.rowHeight(rowsLayout: rowsLayout) - 2 * verticalInset),
            imageView!.heightAnchor.constraint(equalToConstant: BottomRow.rowHeight(rowsLayout: rowsLayout) - 2 * verticalInset),
            widthAnchor.constraint(equalTo: imageView!.widthAnchor, constant: horizontalInset * 2),
        ]
        widthConstraints.forEach { $0.isActive = true }
    }
}
