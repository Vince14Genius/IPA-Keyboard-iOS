//
//  SupportUsPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

struct SupportUsPageWrapped: View {
    var body: some View {
        SupportUsInnerPage()
            .makeStackNavigationPage()
    }
}

struct SupportUsInnerPage: View {
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                SupportUsVStack()
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Localized.navTitleSupportUs)
    }
}

struct SupportUsVStack: View {
    let isDrinkIAPDisabled = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Divider()
            Group {
                Text(Localized.supportUsDonateTitle)
                    .font(.title2)
                Text(Localized.supportUsDonateSubtitle)
                    .foregroundColor(.secondary)
                Button(Localized.supportUsDonateBuyDrink) {
                    
                }
                .disabled(true)
                Button(Localized.supportUsDonateBuyMeal) {
                    
                }
                .disabled(true)
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsRateTitle)
                    .font(.title2)
                Link(destination: URL(string: URLs.appStoreReview)!) {
                    HStack {
                        Image(systemName: "star.fill")
                        Text(Localized.supportUsRateButton)
                    }
                }
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsShareTitle)
                    .font(.title2)
                Link(destination: URL(string: URLs.appStoreReview)!) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text(Localized.supportUsShareButton)
                    }
                }
                    .disabled(true)
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsFriendsAppsTitle)
                    .font(.title2)
                /*
                Link(destination: URL(string: URLs.friendLinkGoLingo)!) {
                    HStack {
                        Image(systemName: "arrow.up.forward.app")
                        Text(Localized.supportUsFriendsAppsGoLingo)
                    }
                }
                */
                Button {} label: {
                    HStack {
                        Image(systemName: "arrow.up.forward.app")
                        Text(Localized.supportUsFriendsAppsTBD)
                    }
                }
                .disabled(true)
            }
            Divider()
                .padding(.top, 8.0)
            Spacer()
        }
        .buttonStyle(SupportUsButtonStyle())
    }
}

struct SupportUsPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsPageWrapped()
    }
}

