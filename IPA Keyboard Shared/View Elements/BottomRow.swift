//
//  BottomRow.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct BottomRow: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var inputViewController: UIInputViewController?
    
    var sectionGlyphs = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            ForEach(0..<sectionGlyphs.count) { i in
                Button {
                    
                } label: {
                    Text(sectionGlyphs[i])
                }
                .foregroundColor(Color(UIColor.secondaryLabel))
                Spacer(minLength: 0)
            }
            Button("⌫") {
                inputViewController?.insertText("\n")
                playSystemKeySound()
            }
            .buttonStyle(ToolbarButtonStyle())
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            BottomRow()
        }
        .preferredColorScheme(.light)
    }
}

/*
for glyph in IPASymbols.sectionGlyphs {
    let glyphButton = UIButton(type: .system)
    glyphButton.setTitle(glyph, for: [])
    glyphButton.titleLabel?.font = glyphButton.titleLabel!.font.withSize(18)
    
    glyphButton.translatesAutoresizingMaskIntoConstraints = false
    
    glyphButton.layer.cornerRadius = 12
    
    glyphButton.addTarget(self, action: #selector(scrollToSection(from:with:)), for: .touchDown)
    bottomButtons.append(glyphButton)
}
*/
