//
//  LayoutSwitcher.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct LayoutSwitcher: View {
    @Environment(\.colorScheme) var colorScheme
    
    enum Direction {
        case up, down
    }
    
    let direction: Direction
    @ObservedObject var state: LayoutSwitcherState
    let keyboardSizeClass: KeyboardSizeClass
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Menu {
                ForEach(KeyboardLayouts.allLayouts.indices, id: \.self) { i in
                    let layout = KeyboardLayouts.allLayouts[i]
                    Button {
                        state.updateCurrentLayout(to: layout)
                    } label: {
                        if layout == state.currentLayout {
                            Label(layout.fullDisplayName, systemImage: "checkmark")
                        } else if layout.isAvailable {
                            Text(layout.fullDisplayName)
                        } else {
                            Label(layout.fullDisplayName, systemImage: "lock.fill")
                        }
                    }
                    .disabled(!layout.isAvailable)
                }
            } label: {
                HStack(spacing: 0) {
                    Text(state.currentLayout.shortenedDisplayName)
                    Label("Layout Switch Menu", systemImage: "chevron.up.chevron.down")
                        .labelStyle(.iconOnly)
                }
                .font(keyboardSizeClass.isWide ? .body : .footnote)
            }
            .foregroundColor(.primary)
            .padding(.horizontal, keyboardSizeClass.isWide ? 16 : 8)
            .frame(
                height: BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass) - 6
            )
            .lineLimit(1)
            .truncationMode(.tail)
            .background(keyboardSizeClass.isWide ? BottomRow.underlayColor(colorScheme: colorScheme) : .clearInteractable)
            .cornerRadius(.infinity)
        }
    }
}
