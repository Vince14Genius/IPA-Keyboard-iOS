//
//  PinnedSymbolKeys.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct PinnedSymbolKeys: View {
    weak var inputViewController: UIInputViewController?
    let keyboardSizeClass: KeyboardSizeClass
    
    var nonfoldable: some View {
        Group {
            Button("[ ]") {
                inputViewController?.typeSandwich(Symbols.squareBrackets)
            }
            Button("/ /") {
                inputViewController?.typeSandwich(Symbols.forwardSlashes)
            }
        }
    }
    
    var foldableExtraCrowded: some View {
        Group {
            Button("~") {
                inputViewController?.type(text: Symbols.tilde)
            }
        }
    }
    
    var foldableNonWide: some View {
        Group {
            Button("◌") {
                inputViewController?.type(text: Symbols.dottedCircle)
            }
            Button("⟨ ⟩") {
                inputViewController?.typeSandwich(Symbols.angleBrackets)
            }
            if LocalStorage.getBool(for: SettingsKey.shouldShowAffricateTieBarsInToolbar) {
                Button("◌͡◌") {
                    inputViewController?.type(text: Symbols.topTieBar)
                }
                Button("◌͜◌") {
                    inputViewController?.type(text: Symbols.bottomTieBar)
                }
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            nonfoldable
            if !keyboardSizeClass.isExtraCrowded {
                foldableExtraCrowded
            }
            if keyboardSizeClass.isWide {
                foldableNonWide
            } else {
                Menu {
                    if keyboardSizeClass.isExtraCrowded {
                        foldableExtraCrowded
                    }
                    foldableNonWide
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .offset(y: 2)
                }
                .foregroundColor(Color(.label))
                .padding([.top, .bottom])
                .padding([.leading, .trailing], Layout.leftInsetRaw)
                .background(Color.clearInteractable)
            }
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}
