//
//  KeyboardLayouts.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

enum KeyboardLayouts {
    static let allLayouts: [KeyboardLayout.Type] = [
        IPASymbols.self,
        ExtIPASymbols.self,
        NonstandardSymbols.self,
        NumberPad.self,
    ]
    
    enum Localized {
        static let shortenedIPAStandard: LocalizedStringKey = "Standard"
        static let fullIPAStandard: LocalizedStringKey = "IPA (Standard)"
        static let shortenedExtIPA: LocalizedStringKey = "extIPA"
        static let fullExtIPA: LocalizedStringKey = "Extended IPA"
        static let shortenedNonstandard: LocalizedStringKey = "Nonstandard"
        static let fullNonstandard: LocalizedStringKey = "Nonstandard & Obsolete Symbols"
    }
}
