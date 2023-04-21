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
        let inputVC = inputViewController
        
        HStack(spacing: 0) {
            if inputVC?.needsInputModeSwitchKey ?? false {
                Spacer(minLength: 0)
            }
            
            let glyphs = dataSource.sectionGlyphs.indices.map {
                GlyphWithID(
                    glyph: dataSource.sectionGlyphs[$0],
                    id: $0
                )
            }
            
            ForEach(glyphs) { element in
                GlyphButton(
                    label: Text(dataSource.sectionGlyphs[element.id]),
                    isSelected: element.id == dataSource.highlightedSectionIndex
                ) {
                    UISelectionFeedbackGenerator().selectionChanged()
                    SystemSound.playInputClick()
                    dataSource.mainAction?(element.id)
                }
                Spacer(minLength: 0)
            }
            
            HoldRepeatButton(label: Image(systemName: "delete.left")) {
                inputVC?.deleteBackwardByOne()
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
