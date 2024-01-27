//
//  EventBanner.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 10/23/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct EventBanner<LabelView: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isVisible: Bool
    let label: () -> LabelView
    
    var body: some View {
        VStack {
            label()
                .padding()
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
    @State private var isLinkCopiedBannerVisible = false
    @State private var isRestoringPurchasesVisible = false
    
    var body: some View {
        ZStack {
            if isLinkCopiedBannerVisible {
                LinkCopiedBanner(isVisible: $isLinkCopiedBannerVisible)
            }
            if isRestoringPurchasesVisible {
                RestoringPurchasesBanner(isVisible: $isRestoringPurchasesVisible)
            }
            VStack {
                Button("Copy Link") {
                    if !isLinkCopiedBannerVisible {
                        isLinkCopiedBannerVisible = true
                    }
                }
                Button("Restore Purchases") {
                    if !isRestoringPurchasesVisible {
                        isRestoringPurchasesVisible = true
                    }
                }
            }
        }
    }
}

#Preview {
    LinkCopiedBannerTest()
}
