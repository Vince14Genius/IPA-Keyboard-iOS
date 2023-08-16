//
//  SettingsLinkButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 8/16/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SettingsLinkButton: View {
    var appearAfter: TimeInterval?
    @State private var isVisible = false
    
    var body: some View {
        Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
            HStack {
                Image(systemName: "arrow.up.forward.app")
                Text(Localized.gettingStartedSettingsButton)
            }
        }
        .buttonStyle(BlueButtonStyle())
        .opacity(isVisible ? 1.0 : 0.0)
        .scaleEffect(isVisible ? 1.0 : 0.7)
        .onAppear {
            guard let appearAfter else {
                isVisible = true
                return
            }
            withAnimation(.spring().delay(appearAfter)) {
                isVisible = true
            }
        }
        .onDisappear {
            isVisible = false
        }
    }
}

struct SettingsLinkButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLinkButton(appearAfter: 0.5)
    }
}
