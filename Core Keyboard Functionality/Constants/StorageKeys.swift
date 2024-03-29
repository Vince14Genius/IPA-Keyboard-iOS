//
//  StorageKeys.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation

enum LocalStorage {
    static func setDefaultValues() {
        guard let userDefaults = UserDefaults(suiteName: SharedIdentifiers.appGroup) else {
            fatalError("Unable to retrieve UserDefaults/AppStorage.")
        }
        userDefaults.register(defaults: defaultValues)
    }
    
    static func getBool(for key: String) -> Bool {
        guard let userDefaults = UserDefaults(suiteName: SharedIdentifiers.appGroup) else {
            fatalError("Unable to retrieve UserDefaults/AppStorage.")
        }
        return userDefaults.bool(forKey: key)
    }
}

enum SharedIdentifiers {
    static let appGroup = "group.com.Vince14Genius.IPA-Keyboard"
}

enum SettingsKey {
    static let isCustomKeyboardEnabled = "isCustomKeyboardEnabled"
    
    static let isRecentsEnabled = "isRecentsEnabled"
    
    static let isNonstandardUnlocked = "isNonstandardUnlocked"
    static let isCustomKeyboardUnlocked = "isCustomKeyboardUnlocked"
    
    static let customKeyboardLayout = "customKeyboardLayout"
    
    static let shouldShowAffricateTieBarsInToolbar = "shouldShowAffricateTieBarsInToolbar"
    
    static let isInputSwitchKeyAlwaysOn = "isInputSwitchKeyAlwaysOn"
    static let isInputClickSoundEnabled = "isInputClickSoundEnabled"
    static let isHapticFeedbackEnabled = "isHapticFeedbackEnabled"
}

enum SupportUsKey {
    static let timesDonatedSmallDrink = "timesDonatedSmallDrink"
    static let timesDonatedLargeMeal = "timesDonatedLargeMeal"
}

fileprivate let defaultValues: [String: Any] = [
    SettingsKey.isCustomKeyboardEnabled: false,
    
    SettingsKey.customKeyboardLayout: [
        // Note that `nil` values are not allowed in UserDefaults
        "ə", "ː", "◌ʰ", "ʙ",
    ],
    
    SettingsKey.isRecentsEnabled: false, // TODO: set value to true once implemented
    
    SettingsKey.shouldShowAffricateTieBarsInToolbar: false,
    
    SettingsKey.isInputSwitchKeyAlwaysOn: false,
    SettingsKey.isInputClickSoundEnabled: true,
    SettingsKey.isHapticFeedbackEnabled: true,
    
    SupportUsKey.timesDonatedSmallDrink: 0,
    SupportUsKey.timesDonatedLargeMeal: 0,
]
