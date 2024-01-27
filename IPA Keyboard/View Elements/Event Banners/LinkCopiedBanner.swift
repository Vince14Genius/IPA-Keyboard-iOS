//
//  LinkCopiedBanner.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 1/25/24.
//  Copyright © 2024 Vince14Genius. All rights reserved.
//

import SwiftUI

struct LinkCopiedBanner: View {
    @Binding var isVisible: Bool
    var body: some View {
        EventBanner(isVisible: $isVisible) {
            HStack {
                Image(systemName: "link")
                Text(Localized.linkCopiedBanner)
            }
            .padding([.leading, .trailing])
        }
    }
}
