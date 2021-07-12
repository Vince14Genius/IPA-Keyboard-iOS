//
//  MainTabView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        TabView {
            GettingStartedPage()
                .tabItem {
                    Image(systemName: "text.book.closed.fill")
                    Text("localized-title-getting-started")
                }
            SupportUsPage()
                .tabItem {
                    Image(systemName: "hand.wave.fill")
                    Text("localized-title-support-us")
                }
            SettingsPage()
                .tabItem {
                    Image(systemName: "gear")
                    Text("localized-title-settings")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
