//
//  GlyphButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphButton: View {
    
    static var textSideLength: Double {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 24
    }
    
    private var horizontalPadding: Double {
        (BottomRow.buttonWidth - GlyphButton.textSideLength) / 2
    }
    
    private var verticalPadding: Double {
        (BottomRow.rowHeight - GlyphButton.textSideLength) / 2
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var label: Text
    var isSelected: Bool
    var action: () -> Void
    
    static func selectedColor(colorScheme: ColorScheme) -> Color {
        .init(white: colorScheme == .light ? 0 : 1, opacity: 0.15)
    }
    
    var body: some View {
        label
            .font(UIDevice.current.userInterfaceIdiom == .pad ? .system(size: GlyphButton.textSideLength * 0.67) : .body)
            .foregroundColor(isSelected ? Color(.label) : Color(.secondaryLabel))
            .frame(minWidth: GlyphButton.textSideLength, minHeight: GlyphButton.textSideLength)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(isSelected ? GlyphButton.selectedColor(colorScheme: colorScheme) : .clear)
            .cornerRadius(.infinity)
            .overlay(Color.clearInteractable)
            .onTapGesture(perform: action)
    }
}

struct GlyphButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            GlyphButton(label: Text("x"), isSelected: true) {}
            Spacer()
            GlyphButton(label: Text("x"), isSelected: false) {}
            Spacer()
        }
        .padding([.leading, .trailing], 6)
        .background(Color(.secondarySystemBackground))
        .preferredColorScheme(.light)
    }
}
