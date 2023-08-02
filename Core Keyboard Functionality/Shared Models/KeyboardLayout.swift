//
//  KeyboardLayout.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/13/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation
import SwiftUI

/**
 A unique identifier for each section in a `keyboardLayout` to retrieve data from `Dictionary` constants
 */
typealias RawSectionID = String

/**
 - `sectionGlyph`: glyphs representing section headers in the keyboard collection view, displayed on the bottom row
 - `localStorageKey`: keys used to access boolean values in UserDefaults to determine which sections are on or off
 - `regularDisplayKeys`: The arrangement of keys in a default sized display setting, with 4 rows instead of 6.
 - `largeDisplayKeys`: The arrangement of keys in a large display setting, with 6 rows instead of 4.
 
 - note: `regularDisplayKeys` and `largeDisplayKeys` must be updated to match each other; use the `keyArrangementConsistencyCheck()` function to check consistency
 */
struct KeyboardSectionData {
    let sectionGlyph: String
    let regularDisplayKeys: [String?]
    let largeDisplayKeys: [String?]
    var ignoredNonOverlappingKeys: [String]? = nil
}

protocol KeyboardLayout {
    static var shortenedDisplayName: LocalizedStringKey { get }
    static var fullDisplayName: LocalizedStringKey { get }
    
    /**
     An iteratable `Array` that contains an ordered list of keyboard sections
     */
    static var sectionNames: [RawSectionID] { get }
    
    /**
     A `Dictionary` that contains all data associated with a keyboard section
     */
    static var sectionData: [RawSectionID: KeyboardSectionData] { get }
    
    /**
     A `UserDefaults` key to retrieve the unlocked status of the keyboard layout
     
     - a `nil` value means that the layout is always available and does not need to be unlocked
     */
    static var storageKeyIsUnlocked: String? { get }
}
