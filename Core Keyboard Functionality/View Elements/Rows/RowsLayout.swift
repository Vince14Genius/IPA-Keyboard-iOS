//
//  RowsLayout.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

enum RowsLayout {
    case padCompact
    case padRegular
    case fullCompact
    case crowdedCompact
    
    static func from(
        sizeClass: UserInterfaceSizeClass,
        uiIdiom: UIUserInterfaceIdiom,
        inputViewController: UIInputViewController?
    ) -> RowsLayout {
        if uiIdiom == .pad {
            switch sizeClass {
            case .compact:
                return .padCompact
            case .regular:
                return .padRegular
            @unknown default:
                fatalError("Unsupported iPad size class <\(sizeClass)>")
            }
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
