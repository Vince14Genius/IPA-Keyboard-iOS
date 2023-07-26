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
    static let shareLink = "https://apps.apple.com/app/ipa-phonetic-keyboard/id1440241497"
    static let appStoreReview = "https://apps.apple.com/app/ipa-phonetic-keyboard/id1440241497?action=write-review"
    static let githubRepo = "https://github.com/Vince14Genius/IPA-Keyboard-iOS"
    static let friendLinkGoLingo = "https://apps.apple.com/app/golingo/id1194977025"
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
    
    /* Getting Started Settings Link Button */
    static let gettingStartedSettingsButton: LocalizedStringKey = "getting-started-settings-button"
    
    /* Getting Started Note */
    static let gettingStartedNoteBullet: LocalizedStringKey = "getting-started-note-bullet-point"
    static let gettingStartedNote: LocalizedStringKey = "getting-started-note"

    /* Getting Started TextField */
    static let gettingStartedTextField: LocalizedStringKey = "keyboardtest.textfield.placeholder"

    /* FAQ Page */
    static let faqGlobeKeyHeading: LocalizedStringKey = "The globe key / switch keyboards key doesn't show up! What do I do???"
    static let faqGlobeKeyDescription: LocalizedStringKey = """
        There used to be a bug where on certain devices the globe key disappears for no reason.
        
        We made a fix already, but if the problem still occurs, follow these steps:
        """
    static let faqGlobeKeyStep1: LocalizedStringKey = "Go to the Settings tab in this app"
    static let faqGlobeKeyStep2: LocalizedStringKey = "Turn on \"Force show input switch key\""
    
    static let faqUnicodeHeading: LocalizedStringKey = "Some of the characters are showing up as weird boxes!"
    static let faqUnicodeBody: LocalizedStringKey = """
        This keyboard types Unicode characters of the IPA symbols.

        It's just that (your version of) iOS doesn't support rendering some of the characters yet.

        The characters you type out will show up correctly on systems that support rendering them.
        """
    static let faqDoesntShowUpHeading: LocalizedStringKey = "The keyboard doesn't show up in the list, even after I tried reinstalling and restarting!"
    static let faqDoesntShowUpBody: LocalizedStringKey = """
        Sometimes (in very rare cases) this does happen with third-party keyboards on iOS.

        Unfortunately there's nothing we could do about it.
        """
    static let faqFutureFeaturesHeading: LocalizedStringKey = "When is non-standard symbols / obsolete symbols / custom keyboard layout / recently used keys coming?"
    static let faqFutureFeaturesBody: LocalizedStringKey = "When I beat my procrastination. :("
    
    /* Support Us - Donate to the developer */
    static let supportUsDonateTitle: LocalizedStringKey = "support-us-donate-title"
    static let supportUsDonateSubtitle: LocalizedStringKey = "support-us-donate-subtitle"
    static let supportUsDonateBuyDrink: LocalizedStringKey = "support-us-donate-buy-drink"
    static let supportUsDonateBuyMeal: LocalizedStringKey = "support-us-donate-buy-meal"
    static func supportUsDonateTotalCount(_ count: Int) -> LocalizedStringKey {
        "support-us-donate-total-count: \(count, specifier: "%lld")"
    }

    /* Support Us - Rate the app if you haven't */
    static let supportUsRateTitle: LocalizedStringKey = "support-us-rate-title"
    static let supportUsRateButton: LocalizedStringKey = "support-us-rate-button"

    /* Support Us - Spread the word on social media */
    static let supportUsShareTitle: LocalizedStringKey = "support-us-share-title"
    static let supportUsShareButton: LocalizedStringKey = "support-us-share-button"
    static let linkCopiedBanner: LocalizedStringKey = "link-copied-banner"

    /* Support Us - Check out our friends' apps */
    static let supportUsFriendsAppsTitle: LocalizedStringKey = "support-us-friends-apps-title"
    static let supportUsFriendsAppsGoLingo: LocalizedStringKey = "support-us-friends-apps-golingo"
    static let supportUsFriendsAppsTBD: LocalizedStringKey = "support-us-friends-apps-tbd"
    
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
    static let restorePurchases: LocalizedStringKey = "button-restore-purchases"

    /* Settings - Bug Report / Feedback */
    static let buttonBugreport: LocalizedStringKey = "localized-button-bugreport"
    
    /* Settings - Advanced Settings */
    static let advancedSettings: LocalizedStringKey = "advanced-settings"
    static let movableCursor: LocalizedStringKey = "settings-movable-cursor"
    static let forceShowGlobeKey: LocalizedStringKey = "Force show input switch key (globe key)"
    static let inputClickSound: LocalizedStringKey = "Keyboard Feedback Sound"
}

enum InAppPurchases {
    static let donationSmallDrink = "donation_small_drink"
    static let donationLargeMeal = "donation_large_meal"
    static let unlockCustomKeyboard = "unlock_custom_ipa_keyboard"
    static let unlockObsoleteNonstandard = "unlock_obsolete_nonstandard_symbols"
    
    /**
     Holds product ID to storage key pairs for nonconsumable IAP items
     */
    static let nonconsumableProductIdToStorageKey = [
        Self.unlockCustomKeyboard: SettingsKey.isCustomKeyboardUnlocked,
        Self.unlockObsoleteNonstandard: SettingsKey.isNonstandardUnlocked,
    ]
    
    /**
     Holds product ID to storage key pairs for consumable IAP items that use simple +1 increments
     */
    static let simpleIncrementProductIdToStorageKey = [
        Self.donationSmallDrink: SupportUsKey.timesDonatedSmallDrink,
        Self.donationLargeMeal: SupportUsKey.timesDonatedLargeMeal,
    ]
}
