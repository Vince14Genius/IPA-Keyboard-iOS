//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation
import SwiftUI

enum IPASymbols: KeyboardLayout {
    static let shortenedDisplayName: LocalizedStringKey = "Standard"
    static let fullDisplayName: LocalizedStringKey = "IPA (Standard)"
    
    static let storageKeyIsUnlocked: String? = nil
    
    private enum sections: RawSectionID, CaseIterable {
        case consonants = "Consonants"
        case nonPulmonic = "NonPulmonic"
        case otherSymbols = "OtherSymbols"
        case vowels = "Vowels"
        case suprasegmentals = "Suprasegmentals"
        case wordAccents = "TonesAndWordAccents"
        case diacritics = "Diacritics"
    }
    
    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }
    
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        sections.consonants.rawValue: .init(
            sectionGlyph: "p",
            regularDisplayKeys: [
                "p", nil, "ɸ", "ʙ",
                "b", "m", "β", "r",
                "p̪", nil, "f", "ʀ",
                "b̪", "ɱ", "v", nil,
                "t̪", nil, "θ", "ⱱ",
                "d̪", "n̪", "ð", "ɾ",
                "t", nil, "s", "ɽ",
                "d", "n", "z", nil,
                nil, nil, "ʃ", "l",
                nil, "n̠", "ʒ", "ɭ",
                "ʈ", nil, "ʂ", "ʎ",
                "ɖ", "ɳ", "ʐ", "ʟ",
                "c", nil, "ç", nil,
                "ɟ", "ɲ", "ʝ", "ʋ",
                "k", nil, "x", "ɹ",
                "ɡ", "ŋ", "ɣ", "ɻ",
                "q", nil, "χ", "j",
                "ɢ", "ɴ", "ʁ", "ɰ",
                nil, nil, "ħ", nil,
                nil, nil, "ʕ", "ɬ",
                nil, nil, "h", "ɮ",
                "ʔ", nil, "ɦ", nil,
            ],
            largeDisplayKeys: [
                "p", "m", "ɸ", "f", "θ", nil,
                "b", "ɱ", "β", "v", "ð", "ʋ",
                "t", nil, "s", "ɬ", nil, nil,
                "d", "n", "z", "ɮ", "ɹ", "l",
                "ʈ", nil, "ʂ", "ʃ", nil, nil,
                "ɖ", "ɳ", "ʐ", "ʒ", "ɻ", "ɭ",
                "c", nil, "ç", nil, nil, nil,
                "ɟ", "ɲ", "ʝ", nil, "j", "ʎ",
                "k", nil, "x", nil, nil, nil,
                "ɡ", "ŋ", "ɣ", nil, "ɰ", "ʟ",
                "q", nil, "χ", nil, nil, nil,
                "ɢ", "ɴ", "ʁ", nil, "h", "ħ",
                "ʔ", nil, nil, nil, "ɦ", "ʕ",
                "ʙ", "r", "ʀ", "ⱱ", "ɾ", "ɽ",
            ],
            ignoredNonOverlappingKeys: [
                "p̪", "b̪", "t̪", "d̪", "n̪", "n̠",
            ]
        ),
        sections.nonPulmonic.rawValue: .init(
            sectionGlyph: "ʘ",
            regularDisplayKeys: [
                "ʘ", "ɓ", nil, "◌ʼ",
                "ǀ", "ɗ", nil, nil,
                "ǃ", "ʄ", nil, nil,
                "ǂ", "ɠ", nil, nil,
                "ǁ", "ʛ",
            ],
            largeDisplayKeys:  [
                "ʘ", "ǀ", "ǃ", "ǂ", "ǁ", nil,
                "ɓ", "ɗ", "ʄ", "ɠ", "ʛ", nil,
                "◌ʼ",
            ]
        ),
        sections.otherSymbols.rawValue: .init(
            sectionGlyph: "ʍ",
            regularDisplayKeys: [
                "ʍ", "ɥ", "ʢ", "ɕ",
                "w", "ʜ", "ʡ", "ʑ",
                "ɺ", "ɧ", "◌͡", "◌͜",
            ],
            largeDisplayKeys: [
                "ʍ", "w", "ɥ", "ʜ", "ʢ", "ʡ",
                "ɕ", "ʑ", "ɺ", "ɧ", "◌͡", "◌͜",
            ]
        ),
        sections.vowels.rawValue: .init(
            sectionGlyph: "i",
            regularDisplayKeys: [
                "i", "e", "ɛ", "æ",
                "y", "ø", "œ", "a",
                "ɪ", nil, nil, "ɶ",
                "ʏ", "ɘ", "ɜ", nil,
                "ɨ", "ə", "ɐ", nil,
                "ʉ", "ɵ", "ɞ", nil,
                "ʊ", nil, nil, nil,
                "ɯ", "ɤ", "ʌ", "ɑ",
                "u", "o", "ɔ", "ɒ",
            ],
            largeDisplayKeys: [
                "i", "ɪ", "e", "ɛ", "æ", "a",
                "y", "ʏ", "ø", "œ", nil, "ɶ",
                "ɨ", "ɘ", "ə", "ɜ", "ɐ", nil,
                "ʉ", "ɵ", nil, "ɞ", nil, nil,
                "ɯ", nil, "ɤ", "ʌ", nil, "ɑ",
                "u", "ʊ", "o", "ɔ", nil, "ɒ",
            ]
        ),
        sections.suprasegmentals.rawValue: .init(
            sectionGlyph: "ː",
            regularDisplayKeys: [
                "ˈ", "ː", "|", ".",
                "ˌ", "ˑ", "‖", "‿",
                nil, "◌̆",
            ],
            largeDisplayKeys: [
                "ˈ", "ˌ", "ː", "ˑ", "◌̆", nil,
                "|", "‖", ".", "‿",
            ]
        ),
        sections.wordAccents.rawValue: .init(
            sectionGlyph: "˥",
            regularDisplayKeys: [
                "◌̋", "˥", "◌̌", "ꜜ",
                "◌́", "˦", "◌̂", "ꜛ",
                "◌̄", "˧", "◌᷄", "↗",
                "◌̀", "˨", "◌᷅", "↘",
                "◌̏", "˩", "◌᷈",
            ],
            largeDisplayKeys: [
                "◌̋", "◌́", "◌̄", "◌̀", "◌̏", nil,
                "˥", "˦", "˧", "˨", "˩", nil,
                "◌̌", "◌̂", "◌᷄", "◌᷅", "◌᷈", nil,
                "ꜜ", "ꜛ", "↗", "↘",
            ]
        ),
        sections.diacritics.rawValue: .init(
            sectionGlyph: "n̥",
            regularDisplayKeys: [
                "◌̥",  "◌̬",  "◌ʰ", "◌̹",
                "◌̊",  "◌̌",  nil,  "◌͗",
                "◌̜",  "◌̟",  "◌̠",  "◌̈",
                "◌͑",  "◌˖", "◌˗", nil,
                "◌̽",  "◌̩",  "◌̯",  "◌˞",
                nil,  "◌̍",  "◌̑",  nil,
                "◌̤",  "◌̰",  "◌̼",  "◌ʷ",
                "◌ʲ", "◌ˠ", "◌ˤ", "◌̴",
                "◌̝",  "◌̞",  "◌̘",  "◌̙",
                "◌˔", "◌˕", nil,  nil,
                "◌̪",  "◌̺",  "◌̻",  "◌̃",
                "◌ⁿ", "◌ˡ", "◌̚",  nil,
                
                "ɚ", "ɝ", "ɫ", nil,
            ],
            largeDisplayKeys: [
                "◌̥",  "◌̬", "◌̹",  "◌̜",  "◌̟",  "◌̠",
                "◌̊",  "◌̌", "◌͗",  "◌͑",  "◌˖", "◌˗",
                "◌ʰ", "◌̈", "◌̽",  "◌̩",  "◌̯",  "◌˞",
                nil,  nil, nil,  "◌̍",  "◌̑",  nil,
                "◌̤",  "◌̰", "◌̼",  "◌ʷ", "◌ʲ", "◌ˠ",
                "◌ˤ", "◌̴", "◌̝",  "◌̞",  "◌̘",  "◌̙",
                nil,  nil, "◌˔", "◌˕", nil,  nil,
                "◌̪",  "◌̺", "◌̻",  "◌̃",  "◌ⁿ", "◌ˡ",
                "◌̚",  nil, nil,  nil,  nil,  nil,
                
                "ɚ", "ɝ", "ɫ",
            ]
        ),
    ]
}
