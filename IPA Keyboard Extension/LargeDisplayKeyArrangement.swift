//
//  LargeDisplayKeyArrangement.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 5/6/20.
//  Copyright © 2020 Vince14Genius. All rights reserved.
//

import Foundation

/**
 - note: Must be updated along with `IPASymbols`
 */
enum LargeDisplayKeyArrangement {
    static let numberOfRows = 6
    
    /**
     The arrangement of keys in a large display setting, with 6 rows instead of 4.
     - note: Must be updated along with `keys` in `IPASymbols`
     */
    static let keys: [String: [String?]] = [
        IPASymbols.sections.consonants.rawValue: [
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
        IPASymbols.sections.nonPulmonic.rawValue: [
            "ʘ", "ǀ", "ǃ", "ǂ", "ǁ", nil,
            "ɓ", "ɗ", "ʄ", "ɠ", "ʛ", nil,
            "◌ʼ",
        ],
        IPASymbols.sections.otherSymbols.rawValue: [
            "ʍ", "w", "ɥ", "ʜ", "ʢ", "ʡ",
            "ɕ", "ʑ", "ɺ", "ɧ", "◌͡", "◌͜",
        ],
        IPASymbols.sections.vowels.rawValue: [
            "i", "ɪ", "e", "ɛ", "æ", "a",
            "y", "ʏ", "ø", "œ", nil, "ɶ",
            "ɨ", "ɘ", "ə", "ɜ", nil, nil,
            "ʉ", "ɵ", nil, "ɞ", "ɐ", nil,
            "ɯ", "ʊ", "ɤ", "ʌ", nil, "ɑ",
            "u", nil, "o", "ɔ", nil, "ɒ",
        ],
        IPASymbols.sections.suprasegmentals.rawValue: [
            "ˈ", "ˌ", "ː", "ˑ", "◌̆", nil,
            "|", "‖", ".", "‿",
        ],
        IPASymbols.sections.wordAccents.rawValue: [
            "◌̋", "◌́", "◌̄", "◌̀", "◌̏", nil,
            "˥", "˦", "˧", "˨", "˩", nil,
            "◌̌", "◌̂", "◌᷄", "◌᷅", "◌᷈", nil,
            "ꜜ", "ꜛ", "↗", "↘",
        ],
        IPASymbols.sections.diacritics.rawValue: [
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
        ],
        IPASymbols.sections.extIPA.rawValue: [
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
        ],
        ]
    
    /**
    Check whether `LargeDisplayKeyArrangement.keys` has been properly updated to match `IPASymbols.keys`
    */
    static func keyArrangementConsistencyCheck() {
        for sectionName in IPASymbols.sectionNames {
            guard let thisSectionDefault = IPASymbols.keys[sectionName] else {
                fatalError("Missing section \"\(sectionName)\" in IPASymbols.keys")
            }
            
            guard let thisSectionLD = LargeDisplayKeyArrangement.keys[sectionName] else {
                fatalError("Missing section \"\(sectionName)\" in LargeDisplayKeyArrangement.keys")
            }
            
            for keyOptional in thisSectionDefault {
                guard let key = keyOptional else { continue }
                if !thisSectionLD.contains(key) {
                    fatalError("Missing key \"\(key)\" in LargeDisplayKeyArrangement.keys[\(sectionName)]")
                }
            }
            
            for keyOptional in thisSectionLD {
                guard let key = keyOptional else { continue }
                if !thisSectionDefault.contains(key) {
                    fatalError("Missing key \"\(key)\" in IPASymbols.keys[\(sectionName)]")
                }
            }
        }
    }
}
