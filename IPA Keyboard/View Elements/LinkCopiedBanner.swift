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
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "link")
                Text(Localized.linkCopiedBanner)
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
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 3_000_000_000) // 3s
                await MainActor.run { isVisible = false }
            }
        }
    }
}

struct LinkCopiedBannerTest: View {
    @State private var isBannerVisible = false
    
    var body: some View {
        ZStack {
            if isBannerVisible {
                LinkCopiedBanner(isVisible: $isBannerVisible)
            }
            Button("Show") {
                if !isBannerVisible {
                    isBannerVisible = true
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
