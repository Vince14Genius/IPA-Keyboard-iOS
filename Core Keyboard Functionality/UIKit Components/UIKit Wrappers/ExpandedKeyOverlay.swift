//
//  ExpandedKeyOverlay.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/17/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import UIKit
import SwiftUI

class ExpandedKeyOverlay: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        hide()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(title: String?, frame: CGRect) {
        guard let titleText = title else { return }
        
        isHidden = false
        self.frame = frame
        
        let hostingController = UIHostingController(rootView: ExpandedKeyBezierPathView(titleText: titleText, baseWidth: frame.width, baseHeight: frame.height))
        addSubview(hostingController.view)
        
        SystemSound.playInputClick()
    }
    
    func hide() {
        isHidden = true
        subviews.forEach { $0.removeFromSuperview() }
    }
}
