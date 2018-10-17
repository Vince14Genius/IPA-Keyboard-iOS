//
//  IPASymbols.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 2018/9/7.
//  Copyright © 2018 Vince14Genius. All rights reserved.
//

import Foundation

enum IPASymbols {
    static let squareBrackets = "[]"
    static let forwardSlashes = "//"
    static let tilde = "~"
    
    enum sections: String {
        case consonants = "Consonants"
        case nonPulmonic = "NonPulmonic"
        case otherSymbols = "OtherSymbols"
        case vowels = "Vowels"
        case suprasegmentals = "Suprasegmentals"
        case wordAccents = "TonesAndWordAccents"
        case diacritics = "Diacritics"
    }
    
    static let sectionNames = [
        IPASymbols.sections.consonants.rawValue,
        IPASymbols.sections.nonPulmonic.rawValue,
        IPASymbols.sections.otherSymbols.rawValue,
        IPASymbols.sections.vowels.rawValue,
        IPASymbols.sections.suprasegmentals.rawValue,
        IPASymbols.sections.wordAccents.rawValue,
        IPASymbols.sections.diacritics.rawValue,
        ]
    
    static let sectionGlyphs: [String] = [
        "p", "ʘ", "ʍ", "i", "ː", "˥", "n̥"
    ]
    
    static let keys: [String: [String?]] = [
        /*
         IPASymbols.sections.consonants.rawValue: [
         "p",      "ɸ",
         "b", "m", "β", "ʙ",
         "f",
         "ɱ", "v", "ⱱ", "ʋ",
         "θ",
         "ð",
         "t",      "s", "ɬ",
         "d", "n", "z", "ɮ", "r", "ɾ", "ɹ", "l",
         "ʃ",
         "ʒ",
         "ʈ",      "ʂ",
         "ɖ", "ɳ", "ʐ", "ɽ", "ɻ", "ɭ",
         "c",      "ç",
         "ɟ", "ɲ", "ʝ", "j", "ʎ",
         "k",      "x",
         "ɡ", "ŋ", "ɣ", "ɰ", "ʟ",
         "q",      "χ",
         "ɢ", "ɴ", "ʁ", "ʀ",
         "ħ",
         "ʕ",
         "ʔ",      "h",
         "ɦ",
         ],
         */
        IPASymbols.sections.consonants.rawValue: [
            "p", "t", "ʈ", "c",
            "b", "d", "ɖ", "ɟ",
            "k", "q", "ʔ", nil,
            "ɡ", "ɢ", nil, nil,
            "m", "ɱ", "n", "ɳ",
            "ɲ", "ŋ", "ɴ", nil,
            "ʙ", "r", nil, "ʀ",
            "ⱱ", "ɾ", "ɽ", nil,
            "ɸ", "θ", "s", "ʃ",
            "β", "ð", "z", "ʒ",
            "ʂ", "ç", "x", "χ",
            "ʐ", "ʝ", "ɣ", "ʁ",
            "ħ", "h", nil, "ɬ",
            "ʕ", "ɦ", nil, "ɮ",
            "ʋ", "ɹ", "ɻ", "j",
            "ɰ", nil, nil, nil,
            "l", "ɭ", "ʎ", "ʟ",
        ],
        IPASymbols.sections.nonPulmonic.rawValue: [
            "ʘ", "ǀ", "ǃ", "ǂ",
            "ǁ", nil, nil, nil,
            "ɓ", "ɗ", "ʄ", "ɠ",
            "ʛ", nil, nil, nil,
            "ʼ",
        ],
        IPASymbols.sections.otherSymbols.rawValue: [
            "ʍ", "w", "ɥ", "ʜ",
            "ʢ", "ʡ", "ɕ", "ʑ",
            "ɺ", "ɧ", "͡", "͜",
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
            "̆", "|", "‖", ".",
            "‿",
        ],
        IPASymbols.sections.wordAccents.rawValue: [
            "̋", "́", "̄", "̀",
            "˥", "˦", "˧", "˨",
            "̏", nil, nil, nil,
            "˩", nil, nil, nil,
            "̌", "̂", "᷄", "᷅",
            "᷈", nil, nil, nil,
            "↓", "↑", "↗", "↘",
        ],
        IPASymbols.sections.diacritics.rawValue: [
            "̥", "̬", "ʰ", "̹",
            "̜", "̟", "̠", "̈",
            "̽", "̩", "̯", "˞",
            "̤", "̰", "̼", "ʷ",
            "ʲ", "ˠ", "ˤ", "̴",
            "̝", "̞", "̘", "̙",
            "̪", "̺", "̻", "̃",
            "ⁿ", "ˡ", "̚", nil,
            
            "ɚ", nil, nil, nil,
            
            "ᵖ", "ᵗ", "ᶜ", "ᵏ",
            "ᵇ", "ᵈ", "ᶡ", "ᶢ",
            "ˀ", nil, nil, nil,
            "ᵐ", "ᶬ", nil, "ᶯ",
            "ᶮ", "ᵑ", "ᶰ", nil,
            "ᶲ", "ᶠ", "ᶿ", "ˢ",
            "ᵝ", "ᵛ", "ᶞ", "ᶻ",
            "ᶴ", "ᶝ", "ᶳ", nil,
            "ᶾ", "ᶽ", "ᶼ", nil,
            "ᶜ̧", "ˣ", "ᵡ", nil,
            "ᶨ", nil, "ʶ", "ʱ",
            "ᶹ", "ʴ", "ʵ", nil,
            "ᶭ", nil, "ᶩ", "ᶫ",
            "ᶣ", "ʳ", nil, nil,
            
            "ⁱ", "ᵉ", "ᵋ", "ᵆ",
            "ʸ", "ᶦ", "ꟹ", "ᵃ",
            "ᶤ", "ᵊ", "ᵌ", nil,
            "ᶶ", "ᶱ", "ᵄ", nil,
            "ᵚ", "ᶷ", "ᶺ", "ᵅ",
            "ᵘ", "ᵒ", "ᵓ", "ᶛ",
        ],
        ]
}
