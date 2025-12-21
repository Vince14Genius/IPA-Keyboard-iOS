//
//  ThaiIPASymbols.swift
//  IPA Keyboard Extension
//
//  Created for Thai IPA Keyboard Project.
//

import Foundation
import SwiftUI

enum ThaiIPASymbols: KeyboardLayout {
    static let shortenedDisplayName: LocalizedStringKey = "Thai"
    static let fullDisplayName: LocalizedStringKey = "Thai IPA"

    static let storageKeyIsUnlocked: String? = nil

    private enum sections: RawSectionID, CaseIterable {
        case consonants = "Thai Consonants"
        case vowels = "Thai Vowels"
        case tones = "Thai Tones"
    }

    static var sectionNames: [RawSectionID] {
        sections.allCases.map { $0.rawValue }
    }

    static let sectionData: [RawSectionID : KeyboardSectionData] = [
        sections.consonants.rawValue: .init(
            sectionGlyph: "k",
            regularDisplayKeys: [
                "k", "c", "d", "t", "b", "p", "ʔ",
                "kh", "ch", "th", "ph", "f", "s", "h",
                "ŋ", "n", "m", "y", "r", "l", "w",
            ],
            largeDisplayKeys: [
                "k", "c", "d", "t", "b", "p", "ʔ",
                "kh", "ch", "th", "ph", "f", "s", "h",
                "ŋ", "n", "m", "y", "r", "l", "w",
            ]
        ),
        sections.vowels.rawValue: .init(
            sectionGlyph: "a",
            regularDisplayKeys: [
                // Short Vowels (use x2 for Long Vowels)
                "a", "i", "ɯ", "u",
                "e", "ɛ", "o", "ɔ", "ə",

                // Diphthongs & Excess
                "ia", "ɯa", "ua",
                "ay", "am", "aw",
            ],
            largeDisplayKeys: [
                "a", "i", "ɯ", "u",
                "e", "ɛ", "o", "ɔ", "ə",
                "ia", "ɯa", "ua",
                "ay", "am", "aw",
            ]
        ),
        sections.tones.rawValue: .init(
            sectionGlyph: "̀",
            regularDisplayKeys: [
                "◌̄", // Mid
                "◌̀", // Low (\)
                "◌̂", // Falling (^)
                "◌́", // High (/)
                "◌̌", // Rising (v)
            ],
            largeDisplayKeys: [
                "◌̄", "◌̀", "◌̂", "◌́", "◌̌",
            ]
        )
    ]
}
