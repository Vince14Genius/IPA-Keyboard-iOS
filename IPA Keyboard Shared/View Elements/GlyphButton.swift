//
//  GlyphButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var label: Text
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        label
            .foregroundColor(isSelected ? Color(.label) : Color(.secondaryLabel))
            .frame(minWidth: 24, minHeight: 24)
            .padding(6)
            .background(isSelected ? Color(white: colorScheme == .light ? 0 : 1, opacity: 0.15) : .clear)
            .cornerRadius(1000)
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
