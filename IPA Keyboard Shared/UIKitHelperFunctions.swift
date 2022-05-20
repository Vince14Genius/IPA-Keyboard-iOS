//
//  UIKitHelperFunctions.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

enum Constraints {
    static func applyEqual<AnchorType>(_ lhs: NSLayoutAnchor<AnchorType>, _ rhs: NSLayoutAnchor<AnchorType>) {
        lhs.constraint(equalTo: rhs).isActive = true
    }
    
    typealias AnchorPair<AnchorType: AnyObject> = (lhs: NSLayoutAnchor<AnchorType>, rhs: NSLayoutAnchor<AnchorType>)
    
    static func applyEqual<AnchorType>(pairs: [AnchorPair<AnchorType>]) {
        pairs.forEach { Self.applyEqual($0.lhs, $0.rhs) }
    }
}
