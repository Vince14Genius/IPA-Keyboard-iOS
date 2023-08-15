//
//  Haptics.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 8/14/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import Foundation

enum Haptics {
    static func play(generatorBlock: () -> Void) {
        let isEnabled = LocalStorage.getBool(for: SettingsKey.isHapticFeedbackEnabled)
        if isEnabled { generatorBlock() }
    }
}
