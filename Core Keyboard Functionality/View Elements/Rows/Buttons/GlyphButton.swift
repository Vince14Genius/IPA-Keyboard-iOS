//
//  GlyphButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphButton: View {
    
    let padTextSizeMultiplier = 0.67
    
    static func textSideLength(keyboardSizeClass: KeyboardSizeClass) -> Double {
        keyboardSizeClass == .padRegular ? 32 : 24
    }
    
    private var horizontalPadding: Double {
        (BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass) - GlyphButton.textSideLength(keyboardSizeClass: keyboardSizeClass)) / 2
    }
    
    private var verticalPadding: Double {
        (BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass) - GlyphButton.textSideLength(keyboardSizeClass: keyboardSizeClass)) / 2
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var label: Text
    var foregroundColor: Color
    var keyboardSizeClass: KeyboardSizeClass
    var action: () -> Void
    
    var body: some View {
        let textSideLength = GlyphButton.textSideLength(keyboardSizeClass: keyboardSizeClass)
        label
            .font(keyboardSizeClass == .padRegular ? .system(size: textSideLength * padTextSizeMultiplier) : .body)
            .foregroundColor(foregroundColor)
            .frame(minWidth: textSideLength, minHeight: textSideLength)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .cornerRadius(.infinity)
            .overlay(Color.clearInteractable)
            .onTapGesture(perform: action)
    }
}

struct GlyphButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            GlyphButton(label: Text("x"), foregroundColor: Color(.label), keyboardSizeClass: .fullCompact) {}
            Spacer()
            GlyphButton(label: Text("x"), foregroundColor: Color(.secondaryLabel), keyboardSizeClass: .fullCompact) {}
            Spacer()
        }
        .padding([.leading, .trailing], 6)
        .background(Color(.secondarySystemBackground))
        .preferredColorScheme(.light)
    }
}
