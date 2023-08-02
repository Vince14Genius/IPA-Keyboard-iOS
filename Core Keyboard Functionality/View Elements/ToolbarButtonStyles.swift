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
            .padding([.leading, .trailing], Layout.leftInsetRaw)
            .background(Color.clearInteractable)
    }
}

public struct BackwardDeleteButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                Image(systemName: configuration.isPressed ? "delete.left.fill" : "delete.left")
                    .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: GlyphButton.textSideLength * 0.67) : .body)
            }
        }
        .frame(width: BottomRow.buttonWidth, height: BottomRow.rowHeight)
        .foregroundColor(Color(.label))
        .background(Color.clearInteractable)
    }
}
