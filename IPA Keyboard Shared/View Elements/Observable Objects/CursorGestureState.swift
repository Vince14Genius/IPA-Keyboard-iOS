//
//  CursorGestureState.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

class CursorGestureState: ObservableObject {
    static let movingOpacity = 0.3
    
    var showKeyCollection: (() -> Void)?
    var hideKeyCollection: (() -> Void)?
    
    @Published var isMovingCursor: Bool = false {
        didSet {
            if isMovingCursor {
                hideKeyCollection?()
            } else {
                showKeyCollection?()
            }
        }
    }
}
