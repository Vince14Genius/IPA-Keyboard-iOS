//
//  StoreManager+Alert.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 1/26/24.
//  Copyright © 2024 Vince14Genius. All rights reserved.
//

import Foundation

extension StoreManager {
    enum Alert {
        case refundAlert(message: String)
        case restoredAlert
        case restoreFailedAlert(errorMessage: String)
    }
}
