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
                SupportUsDefaultButton(label: Localized.supportUsDonateBuyDrink, isDisabled: true) {
                    
                }
                SupportUsDefaultButton(label: Localized.supportUsDonateBuyMeal, isDisabled: true) {
                    
                }
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsRateTitle)
                    .font(.title2)
                SupportUsDefaultButton(icon: Image(systemName: "star.fill"), label: Localized.supportUsRateButton) {
                    UIApplicationFunctions.openURL(URLs.appStoreReview)
                }
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsShareTitle)
                    .font(.title2)
                SupportUsDefaultButton(icon: Image(systemName: "square.and.arrow.up"), label: Localized.supportUsShareButton, isDisabled: true) {
                        UIApplicationFunctions.openURL(URLs.appStoreReview)
                    }
            }
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsFriendsAppsTitle)
                    .font(.title2)
                SupportUsDefaultButton(icon: Image(systemName: "arrow.up.forward.app"), label: Localized.supportUsFriendsAppsGoLingo) {
                    UIApplicationFunctions.openURL(URLs.friendLinkGoLingo)
                }
                SupportUsDefaultButton(icon: Image(systemName: "arrow.up.forward.app"), label: Localized.supportUsFriendsAppsTBD, isDisabled: true) {
                    
                }
            }
            Divider()
                .padding(.top, 8.0)
            Spacer()
        }
    }
}

struct SupportUsPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsPageWrapped()
    }
}

