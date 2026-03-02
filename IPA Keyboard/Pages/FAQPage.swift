//
//  FAQPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/20/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct FAQPageWrapped: View {
    var body: some View {
        FAQInnerPage()
            .makeStackNavigationPage()
    }
}

struct FAQInnerPage: View {
    var body: some View {
        ScrollView {
            FAQVStack()
                .padding()
        }
    }
}

struct FAQVStack: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            sectionBubble {
                Text(Localized.faqGlobeKeyHeading)
                    .font(.headline)
                Text(Localized.faqGlobeKeyDescription)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                InstructionsListItem(index: 1, bodyText: Localized.faqGlobeKeyStep1, isEmbedded: true)
                InstructionsListItem(index: 2, bodyText: Localized.faqGlobeKeyStep2, isEmbedded: true)
            }
            
            sectionBubble {
                Text(Localized.faqUnicodeHeading)
                    .font(.headline)
                Text(Localized.faqUnicodeBody)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
            }
            
            sectionBubble {
                Text(Localized.faqDoesntShowUpHeading)
                    .font(.headline)
                Text(Localized.faqDoesntShowUpBody)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
                Link(destination: URL(string: "https://feedbackassistant.apple.com")!) {
                    HStack {
                        Image(systemName: "link")
                        Text("feedbackassistant.apple.com")
                    }
                }
            }
            
            Link(destination: URL(string: URLs.feedback)!) {
                HStack {
                    Image(systemName: "link")
                    Text(Localized.buttonBugreport)
                }
            }
            
        }
        .buttonStyle(SupportUsButtonStyle())
        .navigationBarTitle("FAQ")
    }
    
    @ViewBuilder
    private func sectionBubble(@ViewBuilder content: () -> some View) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 12.0) {
                content()
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color(colorScheme == .dark ? .secondarySystemBackground : .systemBackground))
        .cornerRadius(32.0)
        .padding([.top, .bottom], 4)
        .shadow(color: colorScheme == .dark ? Color.clear : Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 16, x: 0, y: 4)
    }
}

struct FAQPage_Previews: PreviewProvider {
    static var previews: some View {
        FAQPageWrapped()
    }
}
