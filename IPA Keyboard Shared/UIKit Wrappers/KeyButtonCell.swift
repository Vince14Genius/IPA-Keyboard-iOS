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
        
        self.contentView.addSubview(button)
        self.button.sizeToFit()
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.button.backgroundColor = .clearInteractable
        
        self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        let hostingController = UIHostingController(rootView: KeyButtonView(delegate: self.delegate))
        
        self.contentView.addSubview(hostingController.view)
        
        hostingController.view.sizeToFit()
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        hostingController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        hostingController.view.backgroundColor = .clear
        hostingController.view.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func requestToInitializeAction() -> Bool {
        let returnValue = !didInitializeAction
        didInitializeAction = true
        return returnValue
    }
    
    // Protocol methods
    
    var enableInputClicksWhenVisible: Bool {
        get { return true }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
