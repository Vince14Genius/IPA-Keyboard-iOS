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
                Text("The globe key / switch keyboards key doesn't show up! What do I do???")
                    .font(.title2)
                Text("There used to be a bug where on certain devices the globe key disappears for no reason. We made a fix already, but if the problem still occurs, follow these steps:")
                    .foregroundColor(.secondary)
                InstructionsListItem(index: 1, bodyText: "Go to the Settings tab in this app")
                InstructionsListItem(index: 2, bodyText: "Turn on \"Force show input switch key\"")
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Group {
                Divider()
                Text("Some of the characters are showing up as weird boxes!")
                    .font(.title2)
                Text("This keyboard types Unicode characters of the IPA symbols.\n\nIt's just that (your version of) iOS doesn't support rendering some of the characters yet.\n\nThe characters you type out will show up correctly on systems that support rendering them.")
                    .foregroundColor(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Group {
                Divider()
                Text("The keyboard doesn't show up in the list, even after I tried reinstalling and restarting!")
                    .font(.title2)
                Text("Sometimes (in very rare cases) this does happen with third-party keyboards on iOS.\n\nUnfortunately there's nothing we could do about it.")
                    .foregroundColor(.secondary)
            }
            .fixedSize(horizontal: false, vertical: true) // SwiftUI text truncation bug workaround
            
            Group {
                Divider()
                Text("When is non-standard symbols / obsolete symbols / custom keyboard layout / recently used keys coming?")
                    .font(.title2)
                Text("When I beat my procrastination. :(")
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
