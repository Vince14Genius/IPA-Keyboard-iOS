//
//  LayoutSwitcherState.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

protocol LayoutSwitcherDelegate: AnyObject {
    var currentLayout: KeyboardLayout.Type { get set }
}

class LayoutSwitcherState: ObservableObject {
    @Published private(set) var currentLayout: KeyboardLayout.Type = IPASymbols.self
    weak var controller: LayoutSwitcherDelegate?
    
    func updateCurrentLayout(to newLayout: KeyboardLayout.Type) {
        currentLayout = newLayout // SwiftUI side update
        controller?.currentLayout = newLayout // UIKit side update
    }
}
