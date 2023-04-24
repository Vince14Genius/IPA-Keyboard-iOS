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
    
    var body: some View {
        Group {
            if horizontalSizeClass == .regular {
                MainTabViewRegularSize()
            } else {
                MainTabViewCompactSize()
            }
        }
    }
}

struct MainTabViewRegularSize: View {
    var body: some View {
        NavigationView {
            // Navigation menu list
            List {
                NavigationLink(Localized.titleGettingStarted, destination: GettingStartedInnerPage())
                NavigationLink("FAQ", destination: FAQInnerPage())
                NavigationLink(Localized.titleSupportUs, destination: SupportUsInnerPage())
                NavigationLink(Localized.titleSettings, destination: SettingsInnerPage())
            }
            .navigationTitle(Localized.ipaKeyboardTitle)
            
            // First view
            GettingStartedInnerPage()
        }
    }
}

struct MainTabViewCompactSize: View {
    var body: some View {
        TabView {
            GettingStartedPageWrapped()
                .tabItem {
                    Image(systemName: "text.book.closed.fill")
                    Text(Localized.titleGettingStarted)
                }
            FAQPageWrapped()
                .tabItem {
                    Image(systemName: "questionmark.circle.fill")
                    Text("FAQ")
                }
            SupportUsPageWrapped()
                .tabItem {
                    Image(systemName: "hand.wave.fill")
                    Text(Localized.titleSupportUs)
                }
            SettingsPageWrapped()
                .tabItem {
                    Image(systemName: "gear")
                    Text(Localized.titleSettings)
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTabViewRegularSize()
            MainTabViewCompactSize()
        }
    }
}
