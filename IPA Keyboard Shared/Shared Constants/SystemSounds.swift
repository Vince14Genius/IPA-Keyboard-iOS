//
//  SystemSounds.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import UIKit
import AudioToolbox

enum SystemSound: UInt32 {
    
    case inputClick = 1104
    case delete = 1155
    case modify = 1156
    
    static func playInputClick() {
        guard LocalStorage.getBool(for: SettingsKey.isInputClickSoundEnabled) else { return }
        SystemSound.inputClick.play()
        //UIDevice.current.playInputClick()
    }
    
    func play() {
        AudioServicesPlaySystemSound(rawValue)
    }
}
