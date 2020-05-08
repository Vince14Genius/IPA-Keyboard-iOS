//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation

enum IPASymbols {
    static let numberOfRows = 4
    
    enum sections: String {
        case consonants = "Consonants"
        case nonPulmonic = "NonPulmonic"
        case otherSymbols = "OtherSymbols"
        case vowels = "Vowels"
        case suprasegmentals = "Suprasegmentals"
        case wordAccents = "TonesAndWordAccents"
        case diacritics = "Diacritics"
        case extIPA = "ExtIPA"
    }
    
    enum optionalPaidSections: String {
        case allObsoleteNonstandard = "AllObsoleteAndNonstandardSymbols"
        case obsolete = "Obsolete"
        case sinologist = "Sinitic"
        case americanist = "Americanist"
    }
    
    /**
    Name of section headers in the keyboard collection view
    */
    static let sectionNames = [
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
    Glyphs representing section headers in the keyboard collection view, displayed on the bottom row
    */
    static let sectionGlyphs: [String] = [
        "p", "ʘ", "ʍ", "i", "ː", "˥", "n̥", "ʭ"
    ]
    
    /**
    The arrangement of keys in a default sized display setting, with 4 rows instead of 6.
    - note: Must be updated along with `keys` in `LargeDisplayKeyArrangement`
    */
    static let keys: [String: [String?]] = [
        IPASymbols.sections.consonants.rawValue: [
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
        IPASymbols.sections.nonPulmonic.rawValue: [
            "ʘ", "ǀ", "ǃ", "ǂ",
            "ǁ", nil, nil, nil,
            "ɓ", "ɗ", "ʄ", "ɠ",
            "ʛ", nil, nil, nil,
            "◌ʼ",
        ],
        IPASymbols.sections.otherSymbols.rawValue: [
            "ʍ", "w", "ɥ", "ʜ",
            "ʢ", "ʡ", "ɕ", "ʑ",
            "ɺ", "ɧ", "◌͡", "◌͜",
        ],
        IPASymbols.sections.vowels.rawValue: [
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
        IPASymbols.sections.suprasegmentals.rawValue: [
            "ˈ", "ˌ", "ː", "ˑ",
            "◌̆", "|", "‖", ".",
            "‿",
        ],
        IPASymbols.sections.wordAccents.rawValue: [
            "◌̋", "◌́", "◌̄", "◌̀",
            "˥", "˦", "˧", "˨",
            "◌̏", nil, nil, nil,
            "˩", nil, nil, nil,
            "◌̌", "◌̂", "◌᷄", "◌᷅",
            "◌᷈", nil, nil, nil,
            "ꜜ", "ꜛ", "↗", "↘",
        ],
        IPASymbols.sections.diacritics.rawValue: [
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
        IPASymbols.sections.extIPA.rawValue: [
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
        ]
}
