//
//  LinkCopiedBanner.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 10/23/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct LinkCopiedBanner: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "link")
                Text("Link Copied!")
            }
                .padding()
                .padding([.leading, .trailing])
                .background(colorScheme == .light ? Color(.systemBackground) : Color(.secondarySystemBackground))
                .cornerRadius(32)
                .shadow(color: Color(white: 0, opacity: 0.2), radius: 10, x: 0, y: 2)
            Spacer()
        }
            .transition(.move(edge: .top))
            .transition(.opacity.animation(.easeInOut.speed(0.25)))
            .animation(.easeInOut.speed(0.25))
            .zIndex(1)
    }
}

struct LinkCopiedBannerTest: View {
    @State var isBannerVisible = false
    
    var body: some View {
        ZStack {
            if isBannerVisible {
                LinkCopiedBanner()
            }
            Button("Show") {
                if !isBannerVisible {
                    isBannerVisible = true
                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                        isBannerVisible = false
                    }
                }
            }
        }
    }
}

struct LinkCopiedBanner_Previews: PreviewProvider {
    static var previews: some View {
        LinkCopiedBannerTest()
    }
}
