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
    @State var isLinkCopiedBannerVisible = false
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack(alignment: .top) {
                    SupportUsVStack(isLinkCopiedBannerVisible: $isLinkCopiedBannerVisible)
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitle(Localized.navTitleSupportUs)
            .makeStackNavigationPage()
            .zIndex(0)
            
            // this setup makes the banner go above
            // the navigation title
            
            if isLinkCopiedBannerVisible {
                LinkCopiedBanner()
            }
        }
    }
}

struct SupportUsInnerPage: View {
    @State var isLinkCopiedBannerVisible = false
    
    var body: some View {
        ZStack {
            ScrollView {
                HStack(alignment: .top) {
                    SupportUsVStack(isLinkCopiedBannerVisible: $isLinkCopiedBannerVisible)
                    Spacer()
                }
                .padding()
            }
            .zIndex(0)
            
            if isLinkCopiedBannerVisible {
                LinkCopiedBanner()
            }
        }
        .navigationBarTitle(Localized.navTitleSupportUs)
    }
}

struct SupportUsVStack: View {
    
    @StateObject var storeManager = StoreManager.instance
    
    @Binding var isLinkCopiedBannerVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Divider()
            Group {
                Text(Localized.supportUsDonateTitle)
                    .font(.title2)
                Text(Localized.supportUsDonateSubtitle)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
                HorizontalIAPButton(
                    localizedKey: Localized.supportUsDonateBuyDrink,
                    productIdentifier: InAppPurchases.donationSmallDrink,
                    storeManager: StoreManager.instance
                )
                HorizontalIAPButton(
                    localizedKey: Localized.supportUsDonateBuyMeal,
                    productIdentifier: InAppPurchases.donationLargeMeal,
                    storeManager: StoreManager.instance
                )
                if let drinkCount = appGroupStorage?.integer(forKey: SupportUsKey.timesDonatedSmallDrink),
                   let mealCount = appGroupStorage?.integer(forKey: SupportUsKey.timesDonatedLargeMeal), drinkCount + mealCount > 0 {
                    Text(Localized.supportUsDonateTotalCount(drinkCount + mealCount))
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                }
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
                Button {
                    // copy share link
                    UIPasteboard.general.string = URLs.shareLink
                    
                    // show banner for 3 seconds
                    if !isLinkCopiedBannerVisible {
                        isLinkCopiedBannerVisible = true
                        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                            isLinkCopiedBannerVisible = false
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "doc.on.doc")
                        Text(Localized.supportUsShareButton)
                    }
                }
            }
            /*
            Divider()
                .padding(.top, 8.0)
            Group {
                Text(Localized.supportUsFriendsAppsTitle)
                    .font(.title2)
                Link(destination: URL(string: URLs.friendLinkGoLingo)!) {
                    HStack {
                        Image(systemName: "arrow.up.forward.app")
                        Text(Localized.supportUsFriendsAppsGoLingo)
                    }
                }
                Button {} label: {
                    HStack {
                        Image(systemName: "arrow.up.forward.app")
                        Text(Localized.supportUsFriendsAppsTBD)
                    }
                }
                .disabled(true)
            }
             */
            Divider()
                .padding(.top, 8.0)
            Spacer()
        }
        .buttonStyle(SupportUsButtonStyle())
        .onAppear {
            storeManager.getProducts(productIDs: [
                InAppPurchases.donationLargeMeal,
                InAppPurchases.donationSmallDrink,
            ])
        }
        .toolbar {
            Link("GitHub Repo", destination: URL(string: URLs.githubRepo)!)
        }
    }
}

struct SupportUsPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsPageWrapped()
            .preferredColorScheme(.dark)
    }
}

