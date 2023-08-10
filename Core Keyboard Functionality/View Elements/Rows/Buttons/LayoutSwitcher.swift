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
    
    private var menuIcon: String {
        switch direction {
        case .up: return "arrowtriangle.up.fill"
        case .down: return "arrowtriangle.down.fill"
        }
    }
    
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
                                .labelStyle(.iconOnly)
                        } else if layout.isAvailable {
                            Text(layout.fullDisplayName)
                        } else {
                            Label(layout.fullDisplayName, systemImage: "lock.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                    .disabled(!layout.isAvailable)
                }
            } label: {
                HStack(spacing: 0) {
                    Label("Layout Switch Menu", systemImage: menuIcon)
                        .labelStyle(.iconOnly)
                    Text(state.currentLayout.shortenedDisplayName)
                }
                .font(.footnote)
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, keyboardSizeClass.isWide ? 16 : 8)
            .frame(height: BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass) - 6)
            .background(BottomRow.underlayColor(colorScheme: colorScheme))
            .cornerRadius(.infinity)
        }
    }
}
