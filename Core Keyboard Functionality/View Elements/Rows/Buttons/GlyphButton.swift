//
//  GlyphButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 5/19/22.
//  Copyright © 2022 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphButton: View {
    
    static func textSideLength(rowsLayout: RowsLayout) -> Double {
        rowsLayout == .padRegular ? 32 : 24
    }
    
    private var horizontalPadding: Double {
        (BottomRow.buttonWidth(rowsLayout: rowsLayout) - GlyphButton.textSideLength(rowsLayout: rowsLayout)) / 2
    }
    
    private var verticalPadding: Double {
        (BottomRow.rowHeight(rowsLayout: rowsLayout) - GlyphButton.textSideLength(rowsLayout: rowsLayout)) / 2
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var label: Text
    var foregroundColor: Color
    var rowsLayout: RowsLayout
    var action: () -> Void
    
    var body: some View {
        let textSideLength = GlyphButton.textSideLength(rowsLayout: rowsLayout)
        label
            .font(rowsLayout == .padRegular ? .system(size: textSideLength * 0.67) : .body)
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
            GlyphButton(label: Text("x"), foregroundColor: Color(.label), rowsLayout: .fullCompact) {}
            Spacer()
            GlyphButton(label: Text("x"), foregroundColor: Color(.secondaryLabel), rowsLayout: .fullCompact) {}
            Spacer()
        }
        .padding([.leading, .trailing], 6)
        .background(Color(.secondarySystemBackground))
        .preferredColorScheme(.light)
    }
}
