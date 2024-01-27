//
//  RestoringPurchasesBanner.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 1/25/24.
//  Copyright © 2024 Vince14Genius. All rights reserved.
//

import SwiftUI

struct RestoringPurchasesBanner: View {
    @Binding var isVisible: Bool
    var body: some View {
        EventBanner(isVisible: $isVisible) {
            HStack(spacing: 10) {
                ProgressView()
                Text("Restoring Purchases...")
            }
            .padding([.leading, .trailing], 10)
        }
    }
}
