//
//  SectionsOnOffController.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/13/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import Foundation

protocol KeyboardLayout {
    static var sectionNames: [RawSectionID] { get }
    
    /**
    Glyphs representing section headers in the keyboard collection view, displayed on the bottom row
    */
    static var sectionGlyphs: [RawSectionID: String] { get }
    
    /**
    The arrangement of keys in a default sized display setting, with 4 rows instead of 6.
    - note: Must be updated along with `keys` in `LargeDisplayKeyArrangement`
    */
    static var keys: [RawSectionID: [String?]] { get }
}

enum SectionsOnOffController {
    static func getSections() {
        
    }
}
