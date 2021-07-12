//
//  SettingsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    @State private var isIPAKeyboardOn = true
    @State private var isExtIPAKeyboardOn = true
    @State private var isObsoleteCharsKeyboardOn = false
    @State private var isCustomIPAKeyboardOn = false
    @State private var isRecentsOn = false
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Button {
                        
                    } label: {
                        Text("localized-button-bugreport")
                    }
                }
                Section(header: Text("localized-title-keyboards")) {
                    Toggle("localized-keyboard-ipa", isOn: $isIPAKeyboardOn)
                        .disabled(true)
                    Toggle("localized-keyboard-extipa", isOn: $isExtIPAKeyboardOn)
                    Toggle("localized-keyboard-nonstandard-obsolete", isOn: $isObsoleteCharsKeyboardOn)
                }
                Section() {
                    Toggle("localized-keyboard-custom", isOn: $isCustomIPAKeyboardOn)
                    NavigationLink("localized-link-customize", destination: SettingsCustomKeyboardPage()).disabled(!isCustomIPAKeyboardOn)
                }
                Section() {
                    Toggle("localized-keyboard-recents", isOn: $isRecentsOn)
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}

