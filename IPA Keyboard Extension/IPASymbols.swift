//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation

enum IPASymbols {
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
    
    static let sectionGlyphs: [String] = [
        "p", "ʘ", "ʍ", "i", "ː", "˥", "n̥", "ʭ"
    ]
    
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
            "ɺ", "ɧ", "◌͡◌", "◌͜◌",
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
            "↓", "↑", "↗", "↘",
        ],
        IPASymbols.sections.diacritics.rawValue: [
            "◌̥",  "◌̬",  "◌ʰ", "◌̹",
            "◌̜",  "◌̟",  "◌̠",  "◌̈",
            "◌̽",  "◌̩",  "◌̯",  "◌˞",
            "◌̤",  "◌̰",  "◌̼",  "◌ʷ",
            "◌ʲ", "◌ˠ", "◌ˤ", "◌̴",
            "◌̝",  "◌̞",  "◌̘",  "◌̙",
            "◌̪",  "◌̺",  "◌̻",  "◌̃",
            "◌ⁿ", "◌ˡ", "◌̚",  nil,
            
            "ɚ", "ɝ", "ɫ", nil,
        ],
        IPASymbols.sections.extIPA.rawValue: [
            "ʪ", "ʫ", "ꞎ", "ᶚ",
            "", "", nil, nil,
            "ʩ", nil, nil, nil,
            "ꞯ", nil, nil, nil,
            "ʬ", "ʭ", "¡", nil,
            
            "₍◌", "◌₎", nil, nil,
            "◌˭", nil, nil, nil,
            
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
            
            "◌ⁱ", "◌ᵉ", "◌ᵋ", "◌ᵆ",
            "◌ʸ", "◌ᶦ", "◌ꟹ", "◌ᵃ",
            "◌ᶤ", "◌ᵊ", "◌ᵌ", nil,
            "◌ᶶ", "◌ᶱ", "◌ᵄ", nil,
            "◌ᵚ", "◌ᶷ", "◌ᶺ", "◌ᵅ",
            "◌ᵘ", "◌ᵒ", "◌ᵓ", "◌ᶛ",
        ],
        ]
    
    static let replacementOutputText = [
        // Non-Pulmonic
        "◌ʼ": "ʼ",
        
        // Other Symbols
        "◌͡◌": "͡", "◌͜◌": "͜",
        
        // Suprasegmentals
        "◌̆": "̆",
        
        // Word Accents
        "◌̋": "̋", "◌́": "́", "◌̄": "̄", "◌̀": "̀",
        "◌̏": "̏",
        "◌̌": "̌", "◌̂": "̂", "◌᷄": "᷄", "◌᷅": "᷅",
        "◌᷈": "᷈",
        
        // Diacritics
        "◌̥": "̥",   "◌̬": "̬",   "◌ʰ": "ʰ", "◌̹": "̹",
        "◌̜": "̜",   "◌̟": "̟",   "◌̠": "̠",   "◌̈": "̈",
        "◌̽": "̽",   "◌̩": "̩",   "◌̯": "̯",   "◌˞": "˞",
        "◌̤": "̤",   "◌̰": "̰",   "◌̼": "̼",   "◌ʷ": "ʷ",
        "◌ʲ": "ʲ", "◌ˠ": "ˠ", "◌ˤ": "ˤ",  "◌̴": "̴",
        "◌̝": "̝",   "◌̞": "̞",   "◌̘": "̘",   "◌̙": "̙",
        "◌̪": "̪",   "◌̺": "̺",   "◌̻": "̻",   "◌̃": "̃",
        "◌ⁿ": "ⁿ", "◌ˡ": "ˡ", "◌̚": "̚",
        
        // extIPA
        
        "₍◌": "₍", "◌₎": "₎",
        "◌˭": "˭",
        
        "◌ᵖ": "ᵖ", "◌ᵗ": "ᵗ", "◌ᶜ": "ᶜ", "◌ᵏ": "ᵏ",
        "◌ᵇ": "ᵇ", "◌ᵈ": "ᵈ", "◌ᶡ": "ᶡ", "◌ᶢ": "ᶢ",
        "◌ˀ": "ˀ",
        "◌ᵐ": "ᵐ", "◌ᶬ": "ᶬ", "◌ᶯ": "ᶯ",
        "◌ᶮ": "ᶮ", "◌ᵑ": "ᵑ", "◌ᶰ": "ᶰ",
        "◌ᶲ": "ᶲ", "◌ᶠ": "ᶠ", "◌ᶿ": "ᶿ", "◌ˢ": "ˢ",
        "◌ᵝ": "ᵝ", "◌ᵛ": "ᵛ", "◌ᶞ": "ᶞ", "◌ᶻ": "ᶻ",
        "◌ᶴ": "ᶴ", "◌ᶝ": "ᶝ", "◌ᶳ": "ᶳ",
        "◌ᶾ": "ᶾ", "◌ᶽ": "ᶽ", "◌ᶼ": "ᶼ",
        "◌ᶜ̧": "ᶜ̧", "◌ˣ": "ˣ", "◌ᵡ": "ᵡ",
        "◌ᶨ": "ᶨ", "◌ʶ": "ʶ", "◌ʱ": "ʱ",
        "◌ᶹ": "ᶹ", "◌ʴ": "ʴ", "◌ʵ": "ʵ",
        "◌ᶭ": "ᶭ", "◌ᶩ": "ᶩ", "◌ᶫ": "ᶫ",
        "◌ᶣ": "ᶣ", "◌ʳ": "ʳ",
        
        "◌ⁱ": "ⁱ", "◌ᵉ": "ᵉ", "◌ᵋ": "ᵋ", "◌ᵆ": "ᵆ",
        "◌ʸ": "ʸ", "◌ᶦ": "ᶦ", "◌ꟹ": "ꟹ", "◌ᵃ": "ᵃ",
        "◌ᶤ": "ᶤ", "◌ᵊ": "ᵊ", "◌ᵌ": "ᵌ",
        "◌ᶶ": "ᶶ", "◌ᶱ": "ᶱ", "◌ᵄ": "ᵄ",
        "◌ᵚ": "ᵚ", "◌ᶷ": "ᶷ", "◌ᶺ": "ᶺ", "◌ᵅ": "ᵅ",
        "◌ᵘ": "ᵘ", "◌ᵒ": "ᵒ", "◌ᵓ": "ᵓ", "◌ᶛ": "ᶛ",
    ]
}
