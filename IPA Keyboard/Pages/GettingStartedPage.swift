//
//  GettingStartedPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GettingStartedPage: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("getting-started-description")
                        .font(.title2)
                    InstructionsListItem(index: 1, bodyText: "getting-started-1")
                    InstructionsListItem(index: 2, bodyText: "getting-started-2")
                    InstructionsListItem(index: 3, bodyText: "getting-started-3")
                    InstructionsListItem(index: 4, bodyText: "getting-started-4")
                    HStack(alignment: .top) {
                        Text("getting-started-note-bullet-point")
                        Text("getting-started-note")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(4.0)
                    TextField("keyboardtest.textfield.placeholder", text: $textFieldText)
                        .padding([.top])
                    Divider()
                        .padding([.bottom])
                    Spacer()
                }
                .padding()
                .buttonStyle(BlueButtonStyle())
            }
            .navigationBarTitle("localized-title-getting-started")
            .navigationBarItems(trailing:
                Button("about.ipa.title") {
                    UIApplicationFunctions.openAboutIPAPage()
                }
            )
            .onTapGesture {
                UIApplicationFunctions.hideKeyboard()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct GettingStartedPage_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedPage()
    }
}

