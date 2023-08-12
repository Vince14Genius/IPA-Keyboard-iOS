//
//  NumberPad.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 8/11/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import Foundation
import SwiftUI

enum NumberPad: KeyboardLayout {
    static let shortenedDisplayName: LocalizedStringKey = "NumPad"
    static let fullDisplayName: LocalizedStringKey = "Number Pad"
    
    static var storageKeyIsUnlocked: String? = nil
    
    private enum sections: RawSectionID, CaseIterable {
        case numberPad = "Number Pad"
    }
    
    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }
    
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        sections.numberPad.rawValue: .init(
            sectionGlyph: " ",
            regularDisplayKeys: [
                "7", "4", "1", "-",
                "8", "5", "2", "0",
                "9", "6", "3", ".",
                nil, nil, nil, "+",
            ],
            largeDisplayKeys: [
                "7", "4", "1", nil, nil, "-",
                "8", "5", "2", "0", nil, "+",
                "9", "6", "3", ".", nil, nil,
            ]
        ),
    ]
}
