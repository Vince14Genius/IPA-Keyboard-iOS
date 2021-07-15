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
                    UIApplicationFunctions.openFeedback()
                } label: {
                    Text("localized-button-bugreport")
                }
            }
            Section(header: Text("localized-title-keyboards")) {
                Toggle("localized-keyboard-ipa", isOn: $isIPAKeyboardOn)
                    .disabled(true)
                Toggle("localized-keyboard-extipa", isOn: $isExtIPAKeyboardOn)
                Group {
                    if isNonstandardCharsKeyboardUnlocked {
                        Toggle("localized-keyboard-nonstandard-obsolete", isOn: $isNonstandardCharsKeyboardOn)
                    } else {
                        Button {
                            showingComingSoonAlert = true
                        } label: {
                            Text("localized-unlock-nonstandard-obsolete")
                        }
                    }
                }
            }
            Section() {
                Group {
                    if isCustomIPAKeyboardUnlocked {
                        Toggle("localized-keyboard-custom", isOn: $isCustomIPAKeyboardOn)
                        NavigationLink("localized-link-customize", destination: SettingsCustomKeyboardPage()).disabled(!isCustomIPAKeyboardOn)
                    } else {
                        Button {
                            showingComingSoonAlert = true
                        } label: {
                            Text("localized-unlock-custom")
                        }
                    }
                }
            }
            Section() {
                Toggle("localized-keyboard-recents", isOn: $isRecentsOn)
                    .disabled(true)
            }
        }
        .alert(isPresented: $showingComingSoonAlert, content: {
            Alert(title: Text("alert-coming-soon"), message: nil, dismissButton: .default(Text("alert-dismiss")))
        })
        .navigationBarTitle("Settings")
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}

