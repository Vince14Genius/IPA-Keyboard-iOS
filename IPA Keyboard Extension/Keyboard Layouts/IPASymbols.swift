//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation

enum IPASymbols: KeyboardLayout {
    
    enum sections: RawSectionID, CaseIterable {
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
    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }
    /**
     A `Dictionary` that contains all data associated with a keyboard section
     */
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        IPASymbols.sections.consonants.rawValue: .init(
            sectionGlyph: "p",
            localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.nonPulmonic.rawValue: .init(
            sectionGlyph: "ʘ",
            localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.otherSymbols.rawValue: .init(
            sectionGlyph: "ʍ",
            localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.vowels.rawValue: .init(
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
        IPASymbols.sections.suprasegmentals.rawValue: .init(
            sectionGlyph: "ː",
            localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.wordAccents.rawValue: .init(
            sectionGlyph: "˥",
            localStorageKey: SettingsKey.isIPAEnabled,
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
        IPASymbols.sections.diacritics.rawValue: .init(
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
        IPASymbols.sections.extIPA.rawValue: .init(
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
