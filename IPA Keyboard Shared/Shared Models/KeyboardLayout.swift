//
//  KeyboardLayout.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/13/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation

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
typealias KeyboardSectionData = (sectionGlyph: String, localStorageKey: String, regularDisplayKeys: [String?], largeDisplayKeys: [String?])

protocol KeyboardLayout {
    /**
     An iteratable `Array` that contains an ordered list of keyboard sections
     */
    static var sectionNames: [RawSectionID] { get }
    
    /**
     A `Dictionary` that contains all data associated with a keyboard section
     */
    static var sectionData: [RawSectionID: KeyboardSectionData] { get }
}

extension KeyboardLayout {
    /**
    Check `LocalStorage` to return a list of sections enabled by the user
    */
    static var enabledSections: [RawSectionID] {
        var availableSections = [RawSectionID]()
        for sectionName in Self.sectionNames {
            guard let localStorageKey = Self.sectionData[sectionName]?.localStorageKey else {
                continue
            }
            if LocalStorage.getBool(for: localStorageKey) {
                availableSections.append(sectionName)
            }
        }
        return availableSections
    }
    
    /**
    Check whether `largeDisplayKeys` for each section has been properly updated to match `regularDisplayKeys`
    */
    static func keyArrangementConsistencyCheck() {
        for sectionName in Self.sectionNames {
            guard let thisSection = Self.sectionData[sectionName] else {
                fatalError("Missing section \"\(sectionName)\"")
            }
            
            let thisSectionRD = thisSection.regularDisplayKeys
            let thisSectionLD = thisSection.largeDisplayKeys
            
            for keyOptional in thisSectionRD {
                guard let key = keyOptional else { continue }
                if !thisSectionLD.contains(key) {
                    fatalError("Missing key \"\(key)\" in \(sectionName) regularDisplayKeys]")
                }
            }
            
            for keyOptional in thisSectionLD {
                guard let key = keyOptional else { continue }
                if !thisSectionRD.contains(key) {
                    fatalError("Missing key \"\(key)\" in \(sectionName) largeDisplayKeys")
                }
            }
        }
    }
}
