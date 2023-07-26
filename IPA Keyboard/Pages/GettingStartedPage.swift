//
//  GettingStartedPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GettingStartedPageWrapped: View {
    var body: some View {
        GettingStartedInnerPage()
            .makeStackNavigationPage()
    }
}

struct GettingStartedInnerPage: View {
    var body: some View {
        ScrollView {
            // Main content
            GettingStartedVStack()
                .padding()
        }
        .navigationBarTitle(Localized.titleGettingStarted)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Link(destination: URL(string: URLs.aboutIPA)!) {
                    Text(Localized.aboutIPA)
                }
            }
        }
        .onTapGesture {
            UIApplicationFunctions.hideKeyboard()
        }
    }
}

struct GettingStartedVStack: View {
    @State private var textFieldText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Localized.gettingStartedDescription)
                .font(.title2)
                .padding(.bottom)
            ForEach(Localized.gettingStartedRange, id: \.self) { i in
                InstructionsListItem(index: i, bodyText: Localized.gettingStartedKey(i))
            }
            Group {
                Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                    HStack {
                        Image(systemName: "arrow.up.forward.app")
                        Text(Localized.gettingStartedSettingsButton)
                    }
                }
                    .buttonStyle(BlueButtonStyle())
                UserTipView(bodyText: Localized.gettingStartedNote)
                TextField(Localized.gettingStartedTextField, text: $textFieldText)
            }
                .padding(.top)
            Divider()
                .padding([.bottom])
            Spacer()
        }
    }
}

struct GettingStartedPage_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedPageWrapped()
    }
}

