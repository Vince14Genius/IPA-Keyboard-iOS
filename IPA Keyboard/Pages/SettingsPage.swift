//
//  SettingsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("tab_settings")
                HStack {
                    
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("bugreport.normalTitle")
                        .padding()
                }
            }
            .padding()
            .buttonStyle(BlueButtonStyle())
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}

