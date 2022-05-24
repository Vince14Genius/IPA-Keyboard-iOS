//
//  KeyButtonCell.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/11.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class KeyButtonCell: UICollectionViewCell, UIInputViewAudioFeedback {
    
    // MARK: - Constants and Variables
    
    let delegate = KeyButtonViewDelegate()
    let button = UIButton(type: .custom)
    
    private var didInitializeAction = false
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.backgroundColor = .clearInteractable
        
        let hostingController = UIHostingController(rootView: KeyButtonView(delegate: delegate))
        hostingController.view.backgroundColor = .clear
        hostingController.view.isUserInteractionEnabled = false
        
        func setupView(_ view: UIView) {
            contentView.addSubview(view)
            contentView.sizeToFit()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            Constraints.applyEqual(hPairs: [
                (contentView.leadingAnchor, view.leadingAnchor),
                (contentView.trailingAnchor, view.trailingAnchor),
            ], vPairs: [
                (contentView.topAnchor, view.topAnchor),
                (contentView.bottomAnchor, view.bottomAnchor),
            ])
            
        }
        
        setupView(button)
        setupView(hostingController.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /**
    - returns: `true` if initialize action successful, `false` if this method has ever been run on this
     instance of `KeyButtonCell` previously
     */
    func requestToInitializeAction() -> Bool {
        let returnValue = !didInitializeAction
        didInitializeAction = true
        return returnValue
    }
    
    // Protocol methods
    
    var enableInputClicksWhenVisible: Bool { true }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
