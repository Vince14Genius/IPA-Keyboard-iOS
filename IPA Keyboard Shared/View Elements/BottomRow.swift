//
//  BottomRow.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphWithID: Identifiable {
    var glyph: String
    var id: Int
}

struct BottomRow: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var inputViewController: UIInputViewController?
    
    @ObservedObject var dataSource: BottomRowDataSource
    
    var body: some View {
        HStack(spacing: 0) {
            if inputViewController?.needsInputModeSwitchKey ?? false {
                Spacer(minLength: 0)
            }
            let glyphs = dataSource.sectionGlyphs.indices.map {
                GlyphWithID(
                    glyph: dataSource.sectionGlyphs[$0],
                    id: $0
                )
            }
            ForEach(glyphs) { element in
                Text(dataSource.sectionGlyphs[element.id])
                    .foregroundColor(element.id == dataSource.highlightedSectionIndex ? Color(.label) : Color(.secondaryLabel))
                    .frame(minWidth: 24, minHeight: 24)
                    .padding(6)
                    .background(element.id == dataSource.highlightedSectionIndex ? Color(white: colorScheme == .light ? 0 : 1, opacity: 0.15) : .clear)
                    .cornerRadius(1000)
                    .overlay(Color.clearInteractable)
                    .onTapGesture {
                        UISelectionFeedbackGenerator().selectionChanged()
                        SystemSound.playInputClick()
                        dataSource.mainAction?(element.id)
                    }
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0) // remove after the above code is implemented
            HoldRepeatButton(label: Image(systemName: "delete.left")) {
                inputViewController?.deleteBackwardByOne()
                SystemSound.delete.play()
            }
            .buttonStyle(BackwardDeleteButtonStyle())
        }
        .padding([.leading, .trailing], 6)
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            let dataSource = BottomRowDataSource(sectionGlyphs: ["a", "b", "c", "1", "2", "3", "/"])
            BottomRow(dataSource: dataSource)
                .background(Color(.secondarySystemBackground))
        }
        .preferredColorScheme(.light)
    }
}
