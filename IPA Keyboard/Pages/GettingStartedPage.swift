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
    
    private let animationDelay = 0.12
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(Localized.gettingStartedDescription)
                    .font(.title2)
                    .padding(.bottom)
                ForEach(Localized.gettingStartedRange, id: \.self) { i in
                    InstructionsListItem(index: i, bodyText: Localized.gettingStartedKey(i), transitionAfter: Double(i) * animationDelay)
                }
                VStack(alignment: .leading, spacing: 20.0) {
                    SettingsLinkButton(appearAfter: Double(Localized.gettingStartedRange.upperBound + 1) * animationDelay)
                    UserTipView(bodyText: Localized.gettingStartedNote)
                    gettingStartedTextField()
                    UserTipView(bodyText: Localized.gettingStartedNoteFullAccess)
                }
            }
        }
    }
    
    @ViewBuilder
    private func gettingStartedTextField() -> some View {
        if #available(iOS 26.0, *) {
            VStack(alignment: .leading) {
                TextField(Localized.gettingStartedTextField, text: $textFieldText, axis: .vertical)
                    .lineLimit(5)
                    .padding()
            }
            .glassEffect(.clear.interactive(), in: .rect(cornerRadius: 32.0))
        } else {
            TextField(Localized.gettingStartedTextField, text: $textFieldText)
                .lineLimit(5)
            Divider()
                .padding([.bottom])
        }
    }
}

struct GettingStartedPage_Previews: PreviewProvider {
    static var previews: some View {
        GettingStartedPageWrapped()
    }
}

