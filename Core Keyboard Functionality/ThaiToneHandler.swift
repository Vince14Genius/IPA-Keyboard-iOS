//
//  ThaiToneHandler.swift
//  IPA Keyboard
//
//  Created for Thai IPA Keyboard Project.
//

import UIKit

class ThaiToneHandler {

    // Patterns that should receive the tone on the FIRST character.
    // e.g. "aa" + tone -> "àa"
    private static let targetPatterns: Set<String> = [
        // Long Vowels
        "aa", "ii", "ɯɯ", "uu", "ee", "ɛɛ", "oo", "ɔɔ", "əə",
        // Diphthongs
        "ia", "ɯa", "ua",
        // Excess Vowels
        "ay", "am", "aw"
    ]

    /// Handles tone input. Returns true if handled (custom logic applied), false otherwise.
    static func handleToneInput(_ text: String, proxy: UITextDocumentProxy) -> Bool {
        // Only handle if input is a tone mark
        guard isToneMark(text) else {
            return false
        }

        // Get the text just before the cursor
        guard let precedingText = proxy.documentContextBeforeInput else {
            return false
        }

        // Check for 2-character patterns
        if precedingText.count >= 2 {
            let suffix2 = String(precedingText.suffix(2))

            if targetPatterns.contains(suffix2) {
                // Found a match (e.g. "aa")
                // We want to turn "aa" + tone into "àa"
                // 1. Delete 2 characters
                proxy.deleteBackward()
                proxy.deleteBackward()

                // 2. Construct new string: first char + tone + second char
                let firstChar = String(suffix2.prefix(1))
                let secondChar = String(suffix2.suffix(1))

                proxy.insertText(firstChar + text + secondChar)
                return true
            }
        }

        // Default behavior (let system insert tone normally)
        return false
    }

    private static func isToneMark(_ text: String) -> Bool {
        let tones: Set<String> = ["◌̄", "◌̀", "◌̂", "◌́", "◌̌"]
        // The input might be the combining character itself or with the dotted circle
        // But usually KeyButtonActions might pass cleaned text.
        // Let's check generally.
        // Note: The keyboard sends combining characters.
        // If the KeyButtonActions sends dotted circles, we need to handle that.
        // But KeyButtonActions calls Symbols.removedDottedCircles(text) before calling this.
        // So we expect combining characters like "\u{0304}", "\u{0300}", etc.
        // OR visual representations if that's what is sent.

        // Let's look at ThaiIPASymbols.swift again.
        // "◌̄", "◌̀", etc. are strings containing dotted circle + combining char.
        // Symbols.removedDottedCircles removes the dotted circle.

        // The plain combining chars are:
        // ̄  (Mid - U+0304)
        // ̀  (Low - U+0300)
        // ̂  (Falling - U+0302)
        // ́  (High - U+0301)
        // ̌  (Rising - U+030C)

        let combiningTones: Set<String> = ["\u{0304}", "\u{0300}", "\u{0302}", "\u{0301}", "\u{030C}"]
        return combiningTones.contains(text)
    }
}
