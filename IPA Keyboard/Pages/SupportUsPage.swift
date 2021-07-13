//
//  SupportUsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SupportUsPage: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Donate to the developer")
                        .font(.title2)
                    Button {
                        
                    } label: {
                        Text("🥤 Buy me a drink")
                    }
                    .padding()
                    Button {
                    } label: {
                        Text("🥙 Buy me a meal")
                    }
                    .padding()
                    Text("Rate the app if you haven't")
                        .font(.title2)
                    Button {
                        
                    } label: {
                        Image(systemName: "star.fill")
                        Text("Rate us on the App Store")
                    }
                    .padding()
                    Text("Spread the word on social media")
                        .font(.title2)
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .padding()
                    Text("Check out our friends' apps")
                        .font(.title2)
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.forward.app")
                        Text("GoLingo")
                    }
                    .padding()
                    Spacer()
                }
                .padding()
                .navigationBarTitle("localized-title-support-us-exclamation")
            }
        }
    }
}

struct SupportUsPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsPage()
    }
}

