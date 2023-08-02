//
//  KeySetConsistentAcrossSizesTest.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import XCTest
@testable import IPA_Keyboard

enum KeySetConsistentAcrossSizesTest {
    /**
    Check whether `largeDisplayKeys` for each section has been properly updated to match `regularDisplayKeys`
    */
    static func check(layout: KeyboardLayout.Type) {
        for sectionName in layout.sectionNames {
            guard let thisSection = layout.sectionData[sectionName] else {
                XCTFail("Missing section \"\(sectionName)\"")
                continue
            }
            
            let thisSectionRD = thisSection.regularDisplayKeys
            let thisSectionLD = thisSection.largeDisplayKeys
            
            func isKeyIgnorable(_ key: String) -> Bool {
                guard let ignorableKeys = thisSection.ignoredNonOverlappingKeys else {
                    return false
                }
                return ignorableKeys.contains(key)
            }
            
            for keyOptional in thisSectionRD {
                guard let key = keyOptional else { continue }
                if isKeyIgnorable(key) { continue }
                if !thisSectionLD.contains(key) {
                    XCTFail("Missing key \"\(key)\" in \(sectionName) largeDisplayKeys")
                }
            }
            
            for keyOptional in thisSectionLD {
                guard let key = keyOptional else { continue }
                if isKeyIgnorable(key) { continue }
                if !thisSectionRD.contains(key) {
                    XCTFail("Missing key \"\(key)\" in \(sectionName) regularDisplayKeys")
                }
            }
        }
    }
}
