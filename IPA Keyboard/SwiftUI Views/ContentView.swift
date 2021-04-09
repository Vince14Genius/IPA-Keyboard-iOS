//
//  ContentView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var textFieldText: String = ""
    @State private var isExtIPAOn: Bool = true
    
    var body: some View {
        TabView {
            InstructionsView()
            NavigationView {
                VStack(alignment: .leading) {
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
                }
                .padding()
                .buttonStyle(MyButtonStyle())
                .navigationBarTitle("Settings")
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
