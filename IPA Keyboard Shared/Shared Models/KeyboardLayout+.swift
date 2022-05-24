//
//  KeyboardLayout+.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 5/24/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import UIKit

extension KeyboardLayout {
    static func getKeySet(section: Int) -> [String?]? {
        let largeDisplayKeySet = Self.sectionData[Self.enabledSections[section]]?.largeDisplayKeys
        let defaultKeySet = Self.sectionData[Self.enabledSections[section]]?.regularDisplayKeys
        return UIDevice.current.userInterfaceIdiom == .pad ? largeDisplayKeySet : defaultKeySet
    }
}
