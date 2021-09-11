//
//  SystemSounds.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import AudioToolbox

func playSystemKeySound() {
    AudioServicesPlaySystemSound(0x450)
}
