//
//  SupportUsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

struct SupportUsPage: View {
    var body: some View {
        SupportUsInnerPage()
            .makeStackNavigationPage()
    }
}

struct SupportUsInnerPage: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Donate to the developer")
                        .font(.title2)
                    Text("Contribute to our effort to keep this IPA keyboard completely free!")
                        .foregroundColor(.secondary)
                    
                    Button {
                        
                    } label: {
                        Text("🥤 Buy me a drink")
                    }
                    .disabled(true)
                    .padding()
                    
                    Button {
                    } label: {
                        Text("🥙 Buy me a meal")
                    }
                    .disabled(true)
                    .padding()
                }
                
                Group {
                    Text("Rate the app if you haven't")
                        .font(.title2)
                    
                    Button {
                        UIApplicationFunctions.openURL(URLs.feedback)
                    } label: {
                        Image(systemName: "star.fill")
                        Text("Rate us on the App Store")
                    }
                    .padding()
                }
                
                Group {
                    Text("Spread the word on social media")
                        .font(.title2)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .disabled(true)
                    .padding()
                }
                
                Group {
                    Text("Check out our friends' apps")
                        .font(.title2)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.forward.app")
                        Text("GoLingo")
                    }
                    .disabled(true)
                    .padding()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.up.forward.app")
                        Text("TBD")
                    }
                    .disabled(true)
                    .padding()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Localized.navTitleSupportUs)
    }
}

struct SupportUsPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsPage()
    }
}

