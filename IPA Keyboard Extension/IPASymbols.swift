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
    
    static let keys: [String: [String]] = [
        IPASymbols.sections.consonants.rawValue: [
            "p", "b", "t", "d",
            "ʈ", "ɖ", "c", "ɟ",
            "k", "ɡ", "q", "ɢ",
            "ɸ", "β", "f", "v",
            "θ", "ð", "s", "z",
            "ʃ", "ʒ", "ʂ", "ʐ",
            "ç", "ʝ", "x", "ɣ",
            "χ", "ʁ", "ħ", "ʕ",
            "h", "ɦ", "ɬ", "ɮ",
            "m", "ɱ", "n", "ɳ",
            "ɲ", "ŋ", "ɴ", "ʔ",
            "ʙ", "r", "ʀ", "ⱱ",
            "ɾ", "ɽ", "j", "ɰ",
            "ʋ", "ɹ", "ɻ", "l",
            "ɭ", "ʎ", "ʟ",
        ],
        IPASymbols.sections.nonPulmonic.rawValue: [
            "ʘ", "ǀ", "ǃ", "ǂ",
            "ǁ", "ɓ", "ɗ", "ʄ",
            "ɠ", "ʛ", "ʼ",
        ],
        IPASymbols.sections.otherSymbols.rawValue: [
            "ʍ", "w", "ɥ", "ʜ",
            "ʢ", "ʡ", "ɕ", "ʑ",
            "ɺ", "ɧ", "͡", "͜",
        ],
        IPASymbols.sections.vowels.rawValue: [
            "i", "y", "ɪ", "ʏ",
            "ɨ", "ʉ", "ɯ", "u",
            "e", "ø", "ɘ", "ɵ",
            "ɤ", "o", "ɛ", "œ",
            "ɜ", "ɞ", "ʌ", "ɔ",
            "a", "ʊ", "ɑ", "ə",
            "æ", "ɶ", "ɐ", "ɒ",
        ],
        IPASymbols.sections.suprasegmentals.rawValue: [
            "ˈ", "ˌ", "ː", "ˑ",
            " ̆", "|", "‖", ".",
            "‿",
        ],
        IPASymbols.sections.wordAccents.rawValue: [
            " ̋", " ́", " ̄", " ̀",
            " ̏", "↓", "↑", " ̌",
            " ̂", " ᷄", " ᷅", " ᷈",
            "˥", "˦", "˧", "˨",
            "˩", "↗", "↘",
        ],
        IPASymbols.sections.diacritics.rawValue: [
            "̥", "̬", "ʰ", "̹",
            "̜", "̟", "̠", "̈",
            "̽", "̩", "̯", "˞",
            "̤", "̰", "̼", "ʷ",
            "ʲ", "ˠ", "ˤ", "̴",
            "̝", "̞", "̘", "̙",
            "̪", "̺", "̻", "̃",
            "ⁿ", "ˡ", "̚", "ɚ",
        ],
    ]
}
