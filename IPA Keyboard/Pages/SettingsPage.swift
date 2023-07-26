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
    
    @StateObject var storeManager = StoreManager.instance
    
    // On-off switches: advanced features
    @AppStorage(SettingsKey.isMovableCursorEnabled, store: appGroupStorage) private var isMovableCursorOn = false
    @AppStorage(SettingsKey.isInputSwitchKeyAlwaysOn, store: appGroupStorage) private var isInputSwitchKeyAlwaysOn = false
    @AppStorage(SettingsKey.isInputClickSoundEnabled, store: appGroupStorage) private var isInputClickSoundEnabled = true
    
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
            Section(header: Text(Localized.titleKeyboards)) {
                Toggle(Localized.keyboardIPA, isOn: $isIPAKeyboardOn)
                    .disabled(true)
                Toggle(Localized.keyboardExtIPA, isOn: $isExtIPAKeyboardOn)
                Group {
                    if isNonstandardCharsKeyboardUnlocked {
                        Toggle(Localized.keyboardNonstandard, isOn: $isNonstandardCharsKeyboardOn)
                    } else {
                        HorizontalIAPButton(
                            localizedKey: Localized.unlockNonstandard,
                            productIdentifier: InAppPurchases.unlockObsoleteNonstandard,
                            storeManager: storeManager,
                            disabledLabel: Localized.alertComingSoon
                        )
                    }
                }
            }
            Section() {
                Group {
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
            }
            Section() {
                Toggle(Localized.keyboardRecents, isOn: $isRecentsOn)
                    .disabled(true)
            }
            Section(header: Text(Localized.advancedSettings)) {
                Toggle(Localized.movableCursor, isOn: $isMovableCursorOn)
                Toggle(Localized.forceShowGlobeKey, isOn: $isInputSwitchKeyAlwaysOn)
                Toggle(Localized.inputClickSound, isOn: $isInputClickSoundEnabled)
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

