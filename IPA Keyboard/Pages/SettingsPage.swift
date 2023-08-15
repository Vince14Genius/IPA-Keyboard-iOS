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

struct KeyboardListRow: View {
    var text: LocalizedStringKey
    
    var body: some View {
        Label {
            Text(text)
                .foregroundColor(.primary)
        } icon: {
            Image(systemName: "checkmark.circle")
                .foregroundColor(.green)
        }
    }
}

struct SettingsPageWrapped: View {
    var body: some View {
        SettingsInnerPage()
            .makeStackNavigationPage()
    }
}

struct SettingsInnerPage: View {
    
    @StateObject var storeManager = StoreManager.instance
    
    // On-off switches: advanced features
    @AppStorage(SettingsKey.isInputSwitchKeyAlwaysOn, store: appGroupStorage) private var isInputSwitchKeyAlwaysOn = false
    @AppStorage(SettingsKey.isInputClickSoundEnabled, store: appGroupStorage) private var isInputClickSoundEnabled = true
    @AppStorage(SettingsKey.isHapticFeedbackEnabled, store: appGroupStorage) private var isHapticFeedbackEnabled = true
    @AppStorage(SettingsKey.shouldShowAffricateTieBarsInToolbar, store: appGroupStorage) private var shouldShowAffricateTieBarsInToolbar = false
    
    // On-off switches: keyboard list
    @AppStorage(SettingsKey.isCustomKeyboardEnabled, store: appGroupStorage) private var isCustomIPAKeyboardOn = false
    @AppStorage(SettingsKey.isRecentsEnabled, store: appGroupStorage) private var isRecentsOn = false
    
    // IAP unlock states
    @AppStorage(SettingsKey.isNonstandardUnlocked, store: appGroupStorage) private var isNonstandardCharsKeyboardUnlocked = false
    @AppStorage(SettingsKey.isCustomKeyboardUnlocked, store: appGroupStorage) private var isCustomIPAKeyboardUnlocked = false
    
    // Alert states
    @State private var showingComingSoonAlert = false
    
    var body: some View {
        Form {
            Section(header: Text(Localized.titleKeyboards)) {
                Group {
                    let localizedKeys = [
                        Localized.keyboardIPA,
                        Localized.keyboardExtIPA
                    ]
                    
                    ForEach(localizedKeys.indices, id: \.self) { i in
                        KeyboardListRow(text: localizedKeys[i])
                    }
                }
                .foregroundColor(.green)
                if isNonstandardCharsKeyboardUnlocked {
                    KeyboardListRow(text: Localized.keyboardNonstandard)
                } else {
                    HorizontalIAPButton(
                        localizedKey: Localized.keyboardNonstandard,
                        productIdentifier: InAppPurchases.unlockObsoleteNonstandard,
                        storeManager: storeManager,
                        hasDisplayLock: true
                    )
                }
            }
            Section {
                if isCustomIPAKeyboardUnlocked {
                    Toggle(Localized.keyboardCustom, isOn: $isCustomIPAKeyboardOn)
                    NavigationLink(Localized.linkCustomize, destination: SettingsCustomKeyboardPage()).disabled(!isCustomIPAKeyboardOn)
                } else {
                    HorizontalIAPButton(
                        localizedKey: Localized.unlockCustom,
                        productIdentifier: InAppPurchases.unlockCustomKeyboard,
                        storeManager: storeManager,
                        disabledLabel: Localized.alertComingSoon
                    )
                }
            }
            Section {
                Toggle(Localized.keyboardRecents, isOn: $isRecentsOn)
                    .disabled(true)
            }
            Section {
                Toggle(Localized.affricateTieBarToggle, isOn: $shouldShowAffricateTieBarsInToolbar)
            }
            Section(header: Text(Localized.advancedSettings)) {
                Toggle(Localized.forceShowGlobeKey, isOn: $isInputSwitchKeyAlwaysOn)
            }
            Section {
                Toggle(Localized.inputClickSound, isOn: $isInputClickSoundEnabled)
                Toggle(Localized.hapticFeedbackToggle, isOn: $isHapticFeedbackEnabled)
            }
        }
        .alert(isPresented: $showingComingSoonAlert, content: {
            Alert(title: Text(Localized.alertComingSoon), message: nil, dismissButton: .default(Text(Localized.alertDismiss)))
        })
        .navigationBarTitle(Localized.titleSettings)
        .toolbar {
            Button(Localized.restorePurchases) {
                storeManager.restoreProducts()
            }
        }
        .onAppear {
            storeManager.getProducts(productIDs: [
                InAppPurchases.unlockCustomKeyboard,
                InAppPurchases.unlockObsoleteNonstandard,
            ])
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageWrapped()
    }
}

