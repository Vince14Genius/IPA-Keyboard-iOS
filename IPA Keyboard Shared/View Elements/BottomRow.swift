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
    
    @State var highlightedSectionIndex = 0
    
    var sectionGlyphs = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var body: some View {
        HStack(spacing: 0) {
            /*
            ForEach(0..<sectionGlyphs.count) { i in
                Text(sectionGlyphs[i])
                    .foregroundColor(i == highlightedSectionIndex ? Color(.label) : Color(.secondaryLabel))
                    .frame(minWidth: 20, minHeight: 20)
                    .padding(2)
                    .background(i == highlightedSectionIndex ? Color(white: colorScheme == .light ? 0 : 1, opacity: 0.15) : .clear)
                    .cornerRadius(1000)
                    .onTapGesture {
                        highlightedSectionIndex = i
                    }
                Spacer(minLength: 0)
            }
            */
            Spacer(minLength: 0) // remove after the above code is implemented
            HoldRepeatButton(label: Text("⌫")) {
                inputViewController?.deleteBackwardByOne()
                SystemSound.delete.play()
            }
            .buttonStyle(ToolbarButtonStyle())
        }
        .padding([.leading, .trailing])
        .padding([.top, .bottom], 2)
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
            BottomRow()
                .background(Color(.secondarySystemBackground))
        }
        .preferredColorScheme(.light)
    }
}
