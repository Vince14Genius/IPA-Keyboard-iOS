//
//  ColorConstants.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/17/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import UIKit

fileprivate let interactableClearOpacity = 0.001

extension Color {
    static var clearInteractable: Color {
        Color(white: 0.5, opacity: interactableClearOpacity)
    }
    
    static var darkModeKeyBackground: Color {
        Color(white: 1, opacity: 0.3)
    }
    
    static let darkModeKeyBackgroundOpacity = 0.3
}

extension UIColor {
    static var clearInteractable: UIColor {
        UIColor(white: 0.5, alpha: CGFloat(interactableClearOpacity))
    }
}
