//
//  SettingsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

var isNonstandardCharsKeyboardUnlocked = false
var isCustomIPAKeyboardUnlocked = false

struct SettingsPage: View {
    var body: some View {
        SettingsInnerPage()
            .makeStackNavigationPage()
    }
}

struct SettingsInnerPage: View {
    @State private var isIPAKeyboardOn = true
    @State private var isExtIPAKeyboardOn = true
    @State private var isNonstandardCharsKeyboardOn = false
    @State private var isCustomIPAKeyboardOn = false
    @State private var isRecentsOn = false
    
    @State private var showingComingSoonAlert = false
    
    var body: some View {
        Form {
            Section() {
                Button {
                    UIApplicationFunctions.openURL(URLs.feedback)
                } label: {
                    Text(Localized.buttonBugreport)
                }
            }
            Section(header: Text(Localized.titleKeyboards)) {
                Toggle(Localized.keyboardIPA, isOn: $isIPAKeyboardOn)
                    .disabled(true)
                Toggle(Localized.keyboardExtIPA, isOn: $isExtIPAKeyboardOn)
                Group {
                    if isNonstandardCharsKeyboardUnlocked {
                        Toggle(Localized.keyboardNonstandard, isOn: $isNonstandardCharsKeyboardOn)
                    } else {
                        Button {
                            showingComingSoonAlert = true
                        } label: {
                            Text(Localized.unlockNonstandard)
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
                        Button {
                            showingComingSoonAlert = true
                        } label: {
                            Text(Localized.unlockCustom)
                        }
                    }
                }
            }
            Section() {
                Toggle(Localized.keyboardRecents, isOn: $isRecentsOn)
                    .disabled(true)
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
        SettingsPage()
    }
}

