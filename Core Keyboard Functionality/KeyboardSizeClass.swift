//
//  KeyboardSizeClass.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

enum KeyboardSizeClass {
    case padRegular
    case fullCompact
    case crowdedCompact
    
    static let crowdedViewportSizeThreshold = 375
    
    static func from(
        sizeClass: UserInterfaceSizeClass,
        inputViewController: UIInputViewController?
    ) -> KeyboardSizeClass {
        if case .regular = sizeClass {
            return .padRegular
        }
        
        guard let inputViewController else { return .fullCompact }
        
        var isCrowded = inputViewController.needsInputModeSwitchKey
        let viewportWidth = inputViewController.view.frame.size.width
        
        // pre-initialization viewport width = 0
        // iPhone 12/13 mini viewport width = 375
        isCrowded ||= 0 < inputViewController.view.frame.size.width && viewportWidth <= 375
        
        return isCrowded ? .crowdedCompact : .fullCompact
    }
}
