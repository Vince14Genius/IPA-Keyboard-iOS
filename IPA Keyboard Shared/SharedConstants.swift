//
//  SharedConstants.swift
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
        userDefaults.register(defaults: settingsDefaultValues)
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
    static let isIPAEnabled = "isIPAEnabled"
    static let isExtIPAEnabled = "isExtIPAEnabled"
    static let isNonstandardEnabled = "isNonstandardEnabled"
    
    static let isCustomKeyboardEnabled = "isCustomKeyboardEnabled"
    
    static let isRecentsEnabled = "isRecentsEnabled"
    
    static let isNonstandardUnlocked = "isNonstandardUnlocked"
    static let isCustomKeyboardUnlocked = "isCustomKeyboardUnlocked"
    
    static let customKeyboardLayout = "customKeyboardLayout"
    
    static let isMovableCursorEnabled = "isMovableCursorEnabled"
}

let settingsDefaultValues: [String: Any] = [
    SettingsKey.isIPAEnabled: true,
    SettingsKey.isExtIPAEnabled: false,
    
    SettingsKey.isNonstandardEnabled: false,
    SettingsKey.isCustomKeyboardEnabled: false,
    
    SettingsKey.customKeyboardLayout: [
        // Note that `nil` values are not allowed in UserDefaults
        "ə", "ː", "◌ʰ", "ʙ",
    ],
    
    SettingsKey.isRecentsEnabled: false, // TODO: set value to true once implemented
    
    SettingsKey.isMovableCursorEnabled: false,
]
