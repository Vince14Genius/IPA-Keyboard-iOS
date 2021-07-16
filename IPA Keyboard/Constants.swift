//
//  Constants.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/15/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

enum URLs {
    static let aboutIPA = Localized.ipaWikipediaURLString.localized()
    static let feedback = "https://vince14genius.github.io/support/"
    static let appStoreReview = "https://apps.apple.com/app/ipa-phonetic-keyboard/id1440241497?action=write-review"
}

enum Localized {
    static let ipaWikipediaURLString = "localized-ipa-wikipedia-url"
    static let ipaWikipediaURL = LocalizedStringKey(stringLiteral: Self.ipaWikipediaURLString)

    /* Basics */
    static let alertDismiss: LocalizedStringKey = "alert-dismiss"

    /* title: LocalizedStringKey = "IPA Keyboard"; */
    static let ipaKeyboardTitle: LocalizedStringKey = "ipakeyboard.title"

    /* Tab View tab names */
    static let titleGettingStarted: LocalizedStringKey = "localized-title-getting-started"
    static let titleSupportUs: LocalizedStringKey = "localized-title-support-us"
    static let titleSettings: LocalizedStringKey = "localized-title-settings"

    /* Navigation titles */
    static let navTitleSupportUs: LocalizedStringKey = "localized-title-support-us-exclamation"

    /* Getting Started - About IPA */
    static let aboutIPA: LocalizedStringKey = "about.ipa.title"

    /* Getting Started Description */
    static let gettingStartedDescription: LocalizedStringKey = "getting-started-description"

    /* Getting Started Instructions */
    static let gettingStartedRange = 1..<5
    static func gettingStartedKey(_ index: Int) -> LocalizedStringKey {
        LocalizedStringKey(stringLiteral: "getting-started-\(index)")
    }
    
    /* Getting Started Note */
    static let gettingStartedNoteBullet: LocalizedStringKey = "getting-started-note-bullet-point"
    static let gettingStartedNote: LocalizedStringKey = "getting-started-note"

    /* Getting Started TextField */
    static let gettingStartedTextField: LocalizedStringKey = "keyboardtest.textfield.placeholder"

    /* Settings - Keyboards */
    static let titleKeyboards: LocalizedStringKey = "localized-title-keyboards"
    static let keyboardIPA: LocalizedStringKey = "localized-keyboard-ipa"
    static let keyboardExtIPA: LocalizedStringKey = "localized-keyboard-extipa"
    static let keyboardNonstandard: LocalizedStringKey = "localized-keyboard-nonstandard-obsolete"
    static let keyboardCustom: LocalizedStringKey = "localized-keyboard-custom"
    static let linkCustomize: LocalizedStringKey = "localized-link-customize"
    static let keyboardRecents: LocalizedStringKey = "localized-keyboard-recents"

    /* Settings - Unlock Keyboards */
    static let unlockNonstandard: LocalizedStringKey = "localized-unlock-nonstandard-obsolete"
    static let unlockCustom: LocalizedStringKey = "localized-unlock-custom"
    static let alertComingSoon: LocalizedStringKey = "alert-coming-soon"

    /* Settings - Bug Report / Feedback */
    static let buttonBugreport: LocalizedStringKey = "localized-button-bugreport"
}
