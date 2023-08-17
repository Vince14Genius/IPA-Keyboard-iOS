//
//  RoutineEveryUpdate.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 8/16/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import Foundation

enum RoutineEveryUpdate {
    enum IAPKey {
        // Change these each update...
        // 1. before first TestFlight build
        // 2. after last TestFlight build, before App Store Review
        static let unlockNonstandard = Prod.unlockNonstandard
        static let unlockCustomLayout = TestFlight.unlockCustomLayout
        
        private enum Prod {
            static let unlockNonstandard = "unlock_obsolete_nonstandard_symbols_PROD"
        }
        
        private enum TestFlight {
            static let unlockNonstandard = "unlock_obsolete_nonstandard_symbols"
            static let unlockCustomLayout = "unlock_custom_ipa_keyboard"
        }
    }
}
