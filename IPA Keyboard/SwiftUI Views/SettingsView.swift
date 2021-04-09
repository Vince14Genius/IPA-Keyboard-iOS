//
//  SettingsView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var isExtIPAOn: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("ipa.text")
                    Toggle("extipa.text", isOn: $isExtIPAOn)
                }
                
                Spacer()
                Button {
                    
                } label: {
                    Text("bugreport.normalTitle")
                        .padding()
                }
                .padding()
            }
            .buttonStyle(MyButtonStyle())
            .navigationBarTitle("Settings")
        }
        .tabItem {
            Image(systemName: "gear")
            Text("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
