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
    
    static func openAboutIPAPage(_ sender: UIBarButtonItem) {
        Self.openURL(string: NSLocalizedString("IPAWikipediaURL", comment: "URL of the Wikipedia IPA page"))
    }
    
    static func openFeedback(_ sender: Any) {
        Self.openURL(string: "https://vince14genius.github.io/support/")
    }
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
