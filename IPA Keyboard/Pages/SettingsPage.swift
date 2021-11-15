//
//  SettingsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)

struct SettingsPageWrapped: View {
    var body: some View {
        SettingsInnerPage()
            .makeStackNavigationPage()
    }
}

struct SettingsInnerPage: View {
    // On-off switches: advanced features
    @AppStorage(SettingsKey.isMovableCursorEnabled, store: appGroupStorage) private var isMovableCursorOn = false
    
    // On-off switches: keyboard list
    @AppStorage(SettingsKey.isIPAEnabled, store: appGroupStorage) private var isIPAKeyboardOn = true
    @AppStorage(SettingsKey.isExtIPAEnabled, store: appGroupStorage) private var isExtIPAKeyboardOn = true
    @AppStorage(SettingsKey.isNonstandardEnabled, store: appGroupStorage) private var isNonstandardCharsKeyboardOn = false
    @AppStorage(SettingsKey.isCustomKeyboardEnabled, store: appGroupStorage) private var isCustomIPAKeyboardOn = false
    @AppStorage(SettingsKey.isRecentsEnabled, store: appGroupStorage) private var isRecentsOn = false
    
    // IAP unlock states
    @AppStorage(SettingsKey.isNonstandardUnlocked, store: appGroupStorage) private var isNonstandardCharsKeyboardUnlocked = false
    @AppStorage(SettingsKey.isCustomKeyboardUnlocked, store: appGroupStorage) private var isCustomIPAKeyboardUnlocked = false
    
    // Alert states
    @State private var showingComingSoonAlert = false
    
    var body: some View {
        Form {
            Section() {
                Link(Localized.buttonBugreport, destination: URL(string: URLs.feedback)!)
            }
            Section(header: Text(Localized.titleKeyboards)) {
                Toggle(Localized.keyboardIPA, isOn: $isIPAKeyboardOn)
                    .disabled(true)
                Toggle(Localized.keyboardExtIPA, isOn: $isExtIPAKeyboardOn)
                Group {
                    if isNonstandardCharsKeyboardUnlocked {
                        Toggle(Localized.keyboardNonstandard, isOn: $isNonstandardCharsKeyboardOn)
                    } else {
                        Button(Localized.unlockNonstandard) {
                            showingComingSoonAlert = true
                        }
                    }
                }
            }
            Section() {
                Group {
                    if isCustomIPAKeyboardUnlocked {
                        Toggle(Localized.keyboardCustom, isOn: $isCustomIPAKeyboardOn)
                        NavigationLink(Localized.linkCustomize, destination: SettingsCustomKeyboardPage()).disabled(!isCustomIPAKeyboardOn)
                    } else {
                        Button(Localized.unlockCustom) {
                            showingComingSoonAlert = true
                        }
                    }
                }
            }
            Section() {
                Button(Localized.restorePurchases) {
                    
                }
                .disabled(true)
            }
            Section() {
                Toggle(Localized.keyboardRecents, isOn: $isRecentsOn)
                    .disabled(true)
            }
            Section(header: Text(Localized.advancedSettings)) {
                Toggle(Localized.movableCursor, isOn: $isMovableCursorOn)
                Link("GitHub Repository", destination: URL(string: URLs.githubRepo)!)
            }
        }
        .alert(isPresented: $showingComingSoonAlert, content: {
            Alert(title: Text(Localized.alertComingSoon), message: nil, dismissButton: .default(Text(Localized.alertDismiss)))
        })
        .navigationBarTitle(Localized.titleSettings)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageWrapped()
    }
}

