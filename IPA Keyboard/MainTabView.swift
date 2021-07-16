//
//  MainTabView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var textFieldText: String = ""
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                TabView {
                    GettingStartedPage()
                        .tabItem {
                            Image(systemName: "text.book.closed.fill")
                            Text(Localized.titleGettingStarted)
                        }
                    SupportUsPage()
                        .tabItem {
                            Image(systemName: "hand.wave.fill")
                            Text(Localized.titleSupportUs)
                        }
                    SettingsPage()
                        .tabItem {
                            Image(systemName: "gear")
                            Text(Localized.titleSettings)
                        }
                }
            } else {
                NavigationView {
                    List {
                        NavigationLink(Localized.titleGettingStarted, destination: GettingStartedInnerPage())
                        NavigationLink(Localized.titleSupportUs, destination: SupportUsInnerPage())
                        NavigationLink(Localized.titleSettings, destination: SettingsInnerPage())
                    }
                    .navigationTitle(Localized.ipaKeyboardTitle)
                    
                    GettingStartedInnerPage()
                }
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
