//
//  NonstandardSymbols.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import Foundation
import SwiftUI

enum NonstandardSymbols: KeyboardLayout {
    static let shortenedDisplayName: LocalizedStringKey = "Nonstandard"
    static let fullDisplayName: LocalizedStringKey = "Nonstandard & Obsolete Symbols"
    
    static var storageKeyIsUnlocked: String? = SettingsKey.isNonstandardUnlocked
    
    private enum sections: RawSectionID, CaseIterable {
        case ligatures = "Ligatures"
        case numerals = "Numerals"
        case smallCapsAndUppercase = "Small Caps & Uppercase"
        case sinologistAndKoreanist = "Sinologist & Koreanist"
        case americanistAndSlavicist = "Americanist & Slavicist"
        case obsolete = "Obsolete"
        case communityRequested = "Community Requested"
    }
    
    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }
    
    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        sections.ligatures.rawValue: .init(
            sectionGlyph: "ʦ",
            regularDisplayKeys: [
                "ʦ", "ʧ", "ꭧ", "ʨ",
                "ʣ", "ʤ", "ꭦ", "ʥ",
            ],
            largeDisplayKeys: [
                "ʦ", "ʧ", "ꭧ", "ʨ", nil, nil,
                "ʣ", "ʤ", "ꭦ", "ʥ", nil, nil,
            ]
        ),
        sections.numerals.rawValue: .init(
            sectionGlyph: "◌₁",
            regularDisplayKeys: [
                "◌₁", "◌₄", "◌₇", "◌₀",
                "◌₂", "◌₅", "◌₈", nil,
                "◌₃", "◌₆", "◌₉", nil,
                "◌¹", "◌⁴", "◌⁷", "◌⁰",
                "◌²", "◌⁵", "◌⁸", nil,
                "◌³", "◌⁶", "◌⁹", nil,
            ],
            largeDisplayKeys: [
                "◌₁", "◌₃", "◌₅", "◌₇", "◌₉", nil,
                "◌₂", "◌₄", "◌₆", "◌₈", "◌₀", nil,
                nil, nil, nil, nil, nil, nil,
                "◌¹", "◌³", "◌⁵", "◌⁷", "◌⁹", nil,
                "◌²", "◌⁴", "◌⁶", "◌⁸", "◌⁰", nil,
            ]
        ),
        sections.smallCapsAndUppercase.rawValue: .init(
            sectionGlyph: "ᴍ",
            regularDisplayKeys: [
                "ᴀ", "ʜ", "ᴏ", "ᴠ",
                "ʙ", "ɪ", "ᴘ", nil,
                "ᴄ", "ᴊ", "ꞯ", "ᴡ",
                "ᴅ", "ᴋ", "ʀ", "ʏ",
                "ᴇ", "ʟ", "ꜱ", "ᴢ",
                "ꜰ", "ᴍ", "ᴛ", nil,
                "ɢ", "ɴ", "ᴜ", nil,
                "Ɠ", "Œ",
            ],
            largeDisplayKeys: [
                "ᴀ", "ꜰ", "ᴋ", "ᴘ", "ᴜ", "ᴢ",
                "ʙ", "ɢ", "ʟ", "ꞯ", "ᴠ", nil,
                "ᴄ", "ʜ", "ᴍ", "ʀ", "ᴡ", nil,
                "ᴅ", "ɪ", "ɴ", "ꜱ", nil, nil,
                "ᴇ", "ᴊ", "ᴏ", "ᴛ", "ʏ", nil,
                "Ɠ", "Œ",
            ]
        ),
        sections.sinologistAndKoreanist.rawValue: .init(
            sectionGlyph: "ɿ",
            regularDisplayKeys: [
                "ȶ", "ȡ", "ȵ", "ȴ",
                "ɿ", "ʮ", "ʅ", "ʯ",
                "ᴀ", "ᴇ", "ⱻ", nil,
                "꜀◌", "꜁◌", "꜂◌", "꜃◌",
                "◌꜄", "◌꜅", "◌꜆", "◌꜇",
                "ꞏ◌",
            ],
            largeDisplayKeys: [
                "ȶ", "ȡ", "ȵ", "ȴ", nil, "ⱻ",
                "ɿ", "ʮ", "ʅ", "ʯ", "ᴀ", "ᴇ",
                "꜀◌", "꜁◌", "꜂◌", "꜃◌", nil, nil,
                "◌꜄", "◌꜅", "◌꜆", "◌꜇", nil, "ꞏ◌",
            ]
        ),
        sections.americanistAndSlavicist.rawValue: .init(
            sectionGlyph: "š",
            regularDisplayKeys: [
                "ř", "š", "č", "ž",
                "ǰ", "ǧ", "ǯ", nil,
                "λ", "ƛ", "ł", "ẋ",
                "ö", "ü", nil, "ı",
            ],
            largeDisplayKeys: [
                "ř", "š", "č", "ž", nil, "ö",
                "ǰ", "ǧ", "ǯ", nil, nil, "ü",
                "λ", "ƛ", "ł", "ẋ", nil, "ı",
            ]
        ),
        sections.obsolete.rawValue: .init(
            sectionGlyph: "ᶀ",
            regularDisplayKeys: [
                "ᶀ", "ꞔ", "ᶁ", "ᶂ",
                "ᶃ", "ꞕ", "ᶄ", "ᶅ",
                "𝼓", "ᶆ", "ᶇ", "𝼔",
                "ᶈ", "ᶉ", "𝼕", "𝼖",
                "ᶊ", "ᶋ", "ƫ", "ᶌ",
                "ᶍ", "ᶎ", "𝼘", nil,
                nil, nil, nil, nil,
                "ᶏ", "ᶐ", "ᶒ", "ᶓ",
                "ᶔ", "ᶕ", "ᶖ", "𝼚",
                "𝼛", "ᶗ", "ᶙ", nil,
                nil, nil, nil, nil,
                "ƍ", "σ", "ƺ", "ƪ",
                "ʆ", "ʓ", "ř", nil,
            ],
            largeDisplayKeys: [
                "ᶀ", "ꞔ", "ᶁ", "ᶂ", "ᶃ", "ꞕ",
                "ᶄ", "ᶅ", "𝼓", "ᶆ", "ᶇ", "𝼔",
                "ᶈ", "ᶉ", "𝼕", "𝼖", "ᶊ", "ᶋ",
                "ƫ", "ᶌ", "ᶍ", "ᶎ", "𝼘", nil,
                nil, nil, nil, nil, nil, nil,
                "ᶏ", "ᶐ", "ᶒ", "ᶓ", "ᶔ", "ᶕ",
                "ᶖ", "𝼚", "𝼛", "ᶗ", "ᶙ", nil,
                nil, nil, nil, nil, nil, nil,
                "ƍ", "σ", "ƺ", "ƪ", nil, nil,
                "ʆ", "ʓ", "ř", nil, nil, nil,
            ]
        ),
        sections.communityRequested.rawValue: .init(
            sectionGlyph: "ȸ",
            regularDisplayKeys: [
                "◌ʻ", "ȸ", "ȹ", "◌⸋",
                "◌'", nil, nil, nil,
                nil, nil, nil, nil,
                nil, nil, nil, nil,
                "𓂸", "𓂺", nil, nil,
            ],
            largeDisplayKeys: [
                "◌ʻ", "ȸ", "ȹ", "◌⸋", "◌'", nil,
                nil, nil, nil, nil, nil, nil,
                nil, nil, nil, nil, nil, nil,
                nil, nil, nil, nil, nil, nil,
                "𓂸", "𓂺", nil, nil, nil, nil,
            ]
        ),
    ]
}
