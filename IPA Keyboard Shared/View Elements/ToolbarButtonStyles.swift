//
//  ToolbarButtonStyles.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

public struct ToolbarButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color(.label))
            .opacity(configuration.isPressed ? 0.33 : 1)
            .padding([.top, .bottom])
            .padding([.leading, .trailing], 12)
            .background(Color.clearInteractable)
    }
}

public struct CursorButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding([.leading, .trailing], 24)
            .padding([.top, .bottom], 8)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(6)
            .opacity(configuration.isPressed ? 0.67 : 1)
    }
}
