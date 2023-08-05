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
            HStack {
                FAQVStack()
                Spacer()
            }
            .padding()
        }
    }
}

struct FAQVStack: View {
    var body: some View {
        //TODO: localize
        
        VStack(alignment: .leading, spacing: 12.0) {
            Group {
                Divider()
                Text(Localized.faqGlobeKeyHeading)
                    .font(.title2)
                Text(Localized.faqGlobeKeyDescription)
                    .foregroundColor(.secondary)
                InstructionsListItem(index: 1, bodyText: Localized.faqGlobeKeyStep1)
                InstructionsListItem(index: 2, bodyText: Localized.faqGlobeKeyStep2)
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Group {
                Divider()
                Text(Localized.faqUnicodeHeading)
                    .font(.title2)
                Text(Localized.faqUnicodeBody)
                    .foregroundColor(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Group {
                Divider()
                Text(Localized.faqDoesntShowUpHeading)
                    .font(.title2)
                Text(Localized.faqDoesntShowUpBody)
                    .foregroundColor(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Divider()
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
}

struct FAQPage_Previews: PreviewProvider {
    static var previews: some View {
        FAQPageWrapped()
    }
}
