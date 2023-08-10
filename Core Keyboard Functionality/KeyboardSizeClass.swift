//
//  KeyboardSizeClass.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

enum KeyboardSizeClass: String {
    case padRegular
    case fullCompact
    case crowdedCompact
    
    static let crowdedViewportSizeThreshold = 375
    
    static func from(
        sizeClass: UserInterfaceSizeClass,
        rootViewController: UIViewController?,
        needsInputModeSwitchKey: Bool
    ) -> KeyboardSizeClass {
        if case .regular = sizeClass {
            return .padRegular
        }
        
        guard let rootViewController else {
            // return `fullCompact` as default value for testing,
            // where a parent view controller is not provided
            return .fullCompact
        }
        
        let viewportWidth = rootViewController.view.frame.width
        
        if
            UIDevice.current.userInterfaceIdiom == .pad,
            600 < viewportWidth
        {
            // deal with iPadOS failure to update size class
            // when user exists floating keyboard mode
            return .padRegular
        }
        
        var isCrowded = needsInputModeSwitchKey
        
        // pre-initialization viewport width = 0
        // iPhone 12/13 mini viewport width = 375
        isCrowded ||= 0 < viewportWidth && viewportWidth <= 375
        
        return isCrowded ? .crowdedCompact : .fullCompact
    }
}
