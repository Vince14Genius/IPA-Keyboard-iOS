//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation

enum IPASymbols: KeyboardLayout {
    
    enum sections: RawSectionID {
        case consonants = "Consonants"
        case nonPulmonic = "NonPulmonic"
        case otherSymbols = "OtherSymbols"
        case vowels = "Vowels"
        case suprasegmentals = "Suprasegmentals"
        case wordAccents = "TonesAndWordAccents"
        case diacritics = "Diacritics"
        case extIPA = "ExtIPA"
    }
    
    enum optionalPaidSections: RawSectionID {
        case allObsoleteNonstandard = "AllObsoleteAndNonstandardSymbols"
        case obsolete = "Obsolete"
        case sinologist = "Sinitic"
        case americanist = "Americanist"
    }
    
    /**
     An iteratable `Array` that contains an ordered list of keyboard sections
     */
    static let sectionNames: [RawSectionID] = [
        IPASymbols.sections.consonants.rawValue,
        IPASymbols.sections.nonPulmonic.rawValue,
        IPASymbols.sections.otherSymbols.rawValue,
        IPASymbols.sections.vowels.rawValue,
        IPASymbols.sections.suprasegmentals.rawValue,
        IPASymbols.sections.wordAccents.rawValue,
        IPASymbols.sections.diacritics.rawValue,
        IPASymbols.sections.extIPA.rawValue,
        ]
    
    /**
     A `Dictionary` that contains all data associated with a keyboard section
     */
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        IPASymbols.sections.consonants.rawValue:
            (
                sectionGlyph: "p",
                localStorageKey: SettingsKey.isIPAEnabled,
                regularDisplayKeys: [
                    "p", "t", "ʈ", "c",
                    "b", "d", "ɖ", "ɟ",
                    "k", "q", "ʔ", nil,
                    "ɡ", "ɢ", nil, nil,
                    "m", "ɱ", "n", "ɳ",
                    "ɲ", "ŋ", "ɴ", nil,
                    "ʙ", "r", nil, "ʀ",
                    "ⱱ", "ɾ", "ɽ", nil,
                    "ɸ", "f", "θ", "s",
                    "β", "v", "ð", "z",
                    "ʃ", "ʂ", "ç", "x",
                    "ʒ", "ʐ", "ʝ", "ɣ",
                    "χ", "ħ", "h", nil,
                    "ʁ","ʕ", "ɦ", nil,
                    "ɬ", nil, nil, nil,
                    "ɮ", nil, nil, nil,
                    "ʋ", "ɹ", "ɻ", "j",
                    "ɰ", nil, nil, nil,
                    "l", "ɭ", "ʎ", "ʟ",
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
                ]
            ),
        IPASymbols.sections.nonPulmonic.rawValue:
            (
                sectionGlyph: "ʘ",
                localStorageKey: SettingsKey.isIPAEnabled,
                regularDisplayKeys: [
                    "ʘ", "ǀ", "ǃ", "ǂ",
                    "ǁ", nil, nil, nil,
                    "ɓ", "ɗ", "ʄ", "ɠ",
                    "ʛ", nil, nil, nil,
                    "◌ʼ",
                ],
                largeDisplayKeys:  [
                    "ʘ", "ǀ", "ǃ", "ǂ", "ǁ", nil,
                    "ɓ", "ɗ", "ʄ", "ɠ", "ʛ", nil,
                    "◌ʼ",
                ]
            ),
        IPASymbols.sections.otherSymbols.rawValue:
            (
                sectionGlyph: "ʍ",
                localStorageKey: SettingsKey.isIPAEnabled,
                regularDisplayKeys: [
                    "ʍ", "w", "ɥ", "ʜ",
                    "ʢ", "ʡ", "ɕ", "ʑ",
                    "ɺ", "ɧ", "◌͡", "◌͜",
                ],
                largeDisplayKeys: [
                    "ʍ", "w", "ɥ", "ʜ", "ʢ", "ʡ",
                    "ɕ", "ʑ", "ɺ", "ɧ", "◌͡", "◌͜",
                ]
            ),
        IPASymbols.sections.vowels.rawValue:
            (
                sectionGlyph: "i",
                localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.suprasegmentals.rawValue:
            (
                sectionGlyph: "ː",
                localStorageKey: SettingsKey.isIPAEnabled,
                regularDisplayKeys: [
                    "ˈ", "ˌ", "ː", "ˑ",
                    "◌̆", "|", "‖", ".",
                    "‿",
                ],
                largeDisplayKeys: [
                    "ˈ", "ˌ", "ː", "ˑ", "◌̆", nil,
                    "|", "‖", ".", "‿",
                ]
            ),
        IPASymbols.sections.wordAccents.rawValue:
            (
                sectionGlyph: "˥",
                localStorageKey: SettingsKey.isIPAEnabled,
                regularDisplayKeys: [
                    "◌̋", "◌́", "◌̄", "◌̀",
                    "˥", "˦", "˧", "˨",
                    "◌̏", nil, nil, nil,
                    "˩", nil, nil, nil,
                    "◌̌", "◌̂", "◌᷄", "◌᷅",
                    "◌᷈", nil, nil, nil,
                    "ꜜ", "ꜛ", "↗", "↘",
                ],
                largeDisplayKeys: [
                    "◌̋", "◌́", "◌̄", "◌̀", "◌̏", nil,
                    "˥", "˦", "˧", "˨", "˩", nil,
                    "◌̌", "◌̂", "◌᷄", "◌᷅", "◌᷈", nil,
                    "ꜜ", "ꜛ", "↗", "↘",
                ]
            ),
        IPASymbols.sections.diacritics.rawValue:
            (
                sectionGlyph: "n̥",
                localStorageKey: SettingsKey.isIPAEnabled,
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
                    // TODO: fix diacritics layout
                    
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
        IPASymbols.sections.extIPA.rawValue:
            (
                sectionGlyph: "ʭ",
                localStorageKey: SettingsKey.isExtIPAEnabled,
                regularDisplayKeys: [
                    // CONSONANTS
                    "ʪ", "ʫ", "ꞎ", "ᶚ",
                    "", "", nil, nil,
                    "ʩ", nil, nil, nil,
                    "ꞯ", nil, nil, nil,
                    "ʬ", "ʭ", nil, nil,
                    
                    // DIACRITICS
                    "◌͋", "◌͌", "◌͊", nil,
                    "◌͈", "◌͉", nil, nil,
                    "◌͆", "◌̪͆", "◌͇", "◌͍",
                    "◌͎", "◌̻", "◌̈", "◌̺",
                    "◌͕", "◌͔", nil, nil,
                    "◌͢", "\\", nil, nil,
                    
                    // CONNECTED SPEECH, UNCERTAINTY ETC.
                    "𝑓", "𝑝", nil, nil,
                    "{", "⸨", "(", ".",
                    "}", "⸩", ")", nil,
                    "◯", "Ⓒ", "Ⓕ", "Ⓖ",
                    "Ⓚ", "Ⓛ", "Ⓝ", "Ⓟ",
                    "Ⓡ", "Ⓢ", "Ⓣ", "Ⓥ",
                    
                    // VOICING
                    "ˬ", "₍◌", "◌₎", nil,
                    "◌˭", "ʰ◌", nil, nil,
                    
                    // OTHER SOUNDS
                    "¡", "*", nil, nil,
                    
                    nil, nil, nil, nil,
                    
                    // SUPERSCRIPTS
                    "◌ᵖ", "◌ᵗ", "◌ᶜ", "◌ᵏ",
                    "◌ᵇ", "◌ᵈ", "◌ᶡ", "◌ᶢ",
                    "◌ˀ",  nil,  nil,  nil,
                    "◌ᵐ", "◌ᶬ",  nil, "◌ᶯ",
                    "◌ᶮ", "◌ᵑ", "◌ᶰ",  nil,
                    "◌ᶲ", "◌ᶠ", "◌ᶿ", "◌ˢ",
                    "◌ᵝ", "◌ᵛ", "◌ᶞ", "◌ᶻ",
                    "◌ᶴ", "◌ᶝ", "◌ᶳ",  nil,
                    "◌ᶾ", "◌ᶽ", "◌ᶼ",  nil,
                    "◌ᶜ̧", "◌ˣ", "◌ᵡ",  nil,
                    "◌ᶨ",  nil, "◌ʶ", "◌ʱ",
                    "◌ᶹ", "◌ʴ", "◌ʵ",  nil,
                    "◌ᶭ",  nil, "◌ᶩ", "◌ᶫ",
                    "◌ᶣ", "◌ʳ",  nil,  nil,
                    
                    nil, nil, nil, nil,
                    
                    "◌ⁱ", "◌ᵉ", "◌ᵋ", "◌ᵆ",
                    "◌ʸ", "◌ᶦ", "◌ꟹ", "◌ᵃ",
                    "◌ᶤ", "◌ᵊ", "◌ᵌ", nil,
                    "◌ᶶ", "◌ᶱ", "◌ᵄ", nil,
                    "◌ᵚ", "◌ᶷ", "◌ᶺ", "◌ᵅ",
                    "◌ᵘ", "◌ᵒ", "◌ᵓ", "◌ᶛ",
                ],
                largeDisplayKeys: [
                    // CONSONANTS
                    "ʪ", "ʫ", "ꞎ", "ᶚ", "", "",
                    "ʩ", "ꞯ", "ʬ", "ʭ", nil, nil,
                    
                    // DIACRITICS
                    "◌͋", "◌͌", "◌͊", "◌͈", "◌͉", nil,
                    "◌͆", "◌̪͆", "◌͇", "◌͍", "◌͎", "◌̻",
                    "◌̈", "◌̺", "◌͕", "◌͔", "◌͢", "\\",
                    
                    // CONNECTED SPEECH, UNCERTAINTY ETC.
                    "𝑓", "{", "⸨", "(", ".", nil,
                    "𝑝", "}", "⸩", ")", nil, nil,
                    "◯", "Ⓒ", "Ⓕ", "Ⓖ", "Ⓚ", "Ⓛ",
                    "Ⓝ", "Ⓟ", "Ⓡ", "Ⓢ", "Ⓣ", "Ⓥ",
                    
                    // VOICING
                    "ˬ", "₍◌", "◌₎", "◌˭", "ʰ◌", nil,
                    
                    // OTHER SOUNDS
                    "¡", "*", nil, nil, nil, nil,
                    
                    nil, nil, nil, nil, nil, nil,
                    
                    // SUPERSCRIPTS
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
                    
                    nil, nil, nil, nil, nil, nil,
                    
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
