//
//  GettingStartedPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GettingStartedPage: View {
    var body: some View {
        GettingStartedInnerPage()
            .makeStackNavigationPage()
    }
}

struct GettingStartedInnerPage: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(Localized.gettingStartedDescription)
                    .font(.title2)
                ForEach(Localized.gettingStartedRange) { i in
                    InstructionsListItem(index: i, bodyText: Localized.gettingStartedKey(i))
                }
                HStack(alignment: .top) {
                    Text(Localized.gettingStartedNoteBullet)
                    Text(Localized.gettingStartedNote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(4.0)
                TextField(Localized.gettingStartedTextField, text: $textFieldText)
                    .padding([.top])
                Divider()
                    .padding([.bottom])
                Spacer()
            }
            .padding()
            .buttonStyle(BlueButtonStyle())
        }
        .navigationBarTitle(Localized.titleGettingStarted)
        .navigationBarItems(trailing:
                                Button(Localized.aboutIPA) {
                UIApplicationFunctions.openURL(URLs.aboutIPA)
            }
        )
        .onTapGesture {
            UIApplicationFunctions.hideKeyboard()
        }
    }
}

struct GettingStartedPage_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedPage()
    }
}

