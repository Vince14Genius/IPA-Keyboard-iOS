//
//  UIApplicationFunctions.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import UIKit

enum UIApplicationFunctions {
    static func openURL(string: String) {
        guard let url = URL(string: string) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    static func openAboutIPAPage() {
        Self.openURL(string: NSLocalizedString("localized-ipa-wikipedia-url", comment: "URL of the Wikipedia IPA page"))
    }
    
    static func openFeedback() {
        Self.openURL(string: "https://vince14genius.github.io/support/")
    }
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
