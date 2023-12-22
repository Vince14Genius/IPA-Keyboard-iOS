//
//  ExtIPASymbols.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import Foundation
import SwiftUI

enum ExtIPASymbols: KeyboardLayout {
    static let shortenedDisplayName: LocalizedStringKey = "extIPA"
    static let fullDisplayName: LocalizedStringKey = "Extended IPA"
    
    static var storageKeyIsUnlocked: String? = nil
    
    enum sections: RawSectionID, CaseIterable {
        case consonants = "Consonants"
        case diacritics = "Diacritics"
        case connectedSpeechEtc = "Connected Speech, Uncertainty etc."
        case voicing = "Voicing"
        case otherSounds = "Other Sounds"
        case consonantSuperscripts = "Consonant Superscripts"
        case vowelSuperscripts = "Vowel Superscripts"
    }
    
    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }
    
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        sections.consonants.rawValue: .init(
            sectionGlyph: "ʪ",
            regularDisplayKeys: [
                "ʪ", "ʫ", "ꞎ", "ᶚ",
                "", "", nil, nil,
                "ʩ", nil, nil, nil,
                "ꞯ", nil, nil, nil,
                "ʬ", "ʭ",
            ],
            largeDisplayKeys: [
                "ʪ", "ʫ", "ꞎ", "ᶚ", "", "",
                "ʩ", "ꞯ", "ʬ", "ʭ",
            ]
        ),
        
        sections.diacritics.rawValue: .init(
            sectionGlyph: "m͋",
            regularDisplayKeys: [
                "◌͋", "◌͌", "◌͊", nil,
                "◌͈", "◌͉", nil, nil,
                "◌͆", "◌̪͆", "◌͇", "◌͍",
                "◌͎", "◌̻", "◌̈", "◌̺",
                "◌͕", "◌͔", nil, nil,
                "◌͢", "\\",
            ],
            largeDisplayKeys: [
                "◌͋", "◌͌", "◌͊", "◌͈", "◌͉", nil,
                "◌͆", "◌̪͆", "◌͇", "◌͍", "◌͎", "◌̻",
                "◌̈", "◌̺", "◌͕", "◌͔", "◌͢", "\\",
            ]
        ),
        
        sections.connectedSpeechEtc.rawValue: .init(
            sectionGlyph: "𝑓",
            regularDisplayKeys: [
                "𝑓", "𝑝", nil, nil,
                "{", "⸨", "(", ".",
                "}", "⸩", ")", nil,
                "◯", "Ⓒ", "Ⓕ", "Ⓖ",
                "Ⓚ", "Ⓛ", "Ⓝ", "Ⓟ",
                "Ⓡ", "Ⓢ", "Ⓣ", "Ⓥ",
            ],
            largeDisplayKeys: [
                "𝑓", "{", "⸨", "(", ".", nil,
                "𝑝", "}", "⸩", ")", nil, nil,
                "◯", "Ⓒ", "Ⓕ", "Ⓖ", "Ⓚ", "Ⓛ",
                "Ⓝ", "Ⓟ", "Ⓡ", "Ⓢ", "Ⓣ", "Ⓥ",
            ]
        ),
        
        sections.voicing.rawValue: .init(
            sectionGlyph: "p˭",
            regularDisplayKeys: [
                "ˬ", "₍◌", "◌₎", nil,
                "◌˭", "ʰ◌",
            ],
            largeDisplayKeys: [
                "ˬ", "₍◌", "◌₎", "◌˭", "ʰ◌", nil,
                
                nil, nil, nil, nil, nil, nil,
            ]
        ),
        
        sections.otherSounds.rawValue: .init(
            sectionGlyph: "¡",
            regularDisplayKeys: [
                "¡", "*", nil, nil,
                
                "𝼃", "𝼁", "𝼇", nil,
            ],
            largeDisplayKeys: [
                "¡", "*", nil, "𝼃", "𝼁", "𝼇",
                
                nil, nil, nil, nil, nil, nil,
            ]
        ),
        
        sections.consonantSuperscripts.rawValue: .init(
            sectionGlyph: "◌ᵝ",
            regularDisplayKeys: [
                "◌ᵖ", nil,  "◌ᶲ", nil,
                "◌ᵇ", "◌ᵐ", "◌ᵝ", nil,
                nil,  nil,  "◌ᶠ", nil,
                nil,  "◌ᶬ", "◌ᵛ", "◌ᶹ",
                "◌ᵗ", nil,  "◌ˢ", nil,
                "◌ᵈ", nil,  "◌ᶻ", "◌ʴ",
                "◌ᶿ", "◌ᶝ", nil,  "◌ᶴ",
                "◌ᶞ", "◌ᶽ", nil,  "◌ᶾ",
                nil,  nil,  "◌ᶳ", nil,
                nil,  "◌ᶯ", "◌ᶼ", "◌ʵ",
                "◌ᶜ", nil,  "◌ᶜ̧", nil,
                "◌ᶡ", "◌ᶮ", "◌ᶨ", "◌ᶣ",
                "◌ᵏ", nil,  "◌ˣ", nil,
                "◌ᶢ", "◌ᵑ", nil,  "◌ᶭ",
                nil,  nil,  "◌ᵡ", nil,
                nil,  "◌ᶰ", "◌ʶ", nil,
                "◌ˀ", nil,  nil,  nil,
                nil,  nil,  "◌ʱ", nil,
                "◌ᶩ", "◌ᶫ", nil,  "◌ʳ",
            ],
            largeDisplayKeys: [
                "◌ᵖ", "◌ᵐ", "◌ᶲ", "◌ᶠ", "◌ᶿ", nil,
                "◌ᵇ", "◌ᶬ", "◌ᵝ", "◌ᵛ", "◌ᶞ", "◌ᶹ",
                "◌ᵗ", nil,  "◌ˢ", "◌ᶝ", nil,  nil,
                "◌ᵈ", nil,  "◌ᶻ", "◌ᶽ", "◌ʴ", "◌ʳ",
                nil,  nil,  "◌ᶳ", "◌ᶴ", nil,  "◌ᶩ",
                nil,  "◌ᶯ", "◌ᶼ", "◌ᶾ", "◌ʵ", nil,
                "◌ᶜ", nil,  "◌ᶜ̧", nil,  nil,  nil,
                "◌ᶡ", "◌ᶮ", "◌ᶨ", nil,  "◌ᶣ", nil,
                "◌ᵏ", nil,  "◌ˣ", nil,  nil,  nil,
                "◌ᶢ", "◌ᵑ", nil,  nil,  "◌ᶭ", "◌ᶫ",
                nil,  nil,  "◌ᵡ", nil,  nil,  nil,
                nil,  "◌ᶰ", "◌ʶ", nil,  nil,  nil,
                "◌ˀ", nil,  nil,  nil,  "◌ʱ", nil,
            ]
        ),
        
        sections.vowelSuperscripts.rawValue: .init(
            sectionGlyph: "◌ᵊ",
            regularDisplayKeys: [
                "◌ⁱ", "◌ᵉ", "◌ᵋ", "◌ᵆ",
                "◌ʸ", "◌ᶦ", "◌ꟹ", "◌ᵃ",
                "◌ᶤ", "◌ᵊ", "◌ᵌ", nil,
                "◌ᶶ", "◌ᶱ", "◌ᵄ", nil,
                "◌ᵚ", "◌ᶷ", "◌ᶺ", "◌ᵅ",
                "◌ᵘ", "◌ᵒ", "◌ᵓ", "◌ᶛ",
            ],
            largeDisplayKeys: [
                "◌ⁱ", "◌ᵉ", "◌ᵋ", "◌ᵆ", "◌ᵃ", nil,
                "◌ʸ", "◌ᶦ", "◌ꟹ", nil, nil, nil,
                "◌ᶤ", "◌ᵊ", "◌ᵌ", nil, nil, nil,
                "◌ᶶ", "◌ᶱ", "◌ᵄ", nil, nil, nil,
                "◌ᵚ", "◌ᶷ", "◌ᶺ", nil, "◌ᵅ", nil,
                "◌ᵘ", "◌ᵒ", "◌ᵓ", nil, "◌ᶛ", nil,
            ]
        ),
    ]
}
