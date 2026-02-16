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
                Haptics.play {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                SystemSound.inputClick.play()
                inputViewController?.typeSandwich(Symbols.squareBrackets)
            }
            .accessibilityLabel(Text("Narrow Transcription Brackets"))
            Button("/ /") {
                Haptics.play {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                SystemSound.inputClick.play()
                inputViewController?.typeSandwich(Symbols.forwardSlashes)
            }
            .accessibilityLabel(Text("Broad Transcription Brackets"))
        }
    }
    
    var foldableExtraCrowded: some View {
        Group {
            Button("~") {
                Haptics.play {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                SystemSound.inputClick.play()
                inputViewController?.type(text: Symbols.tilde)
            }
        }
    }
    
    var foldableNonWide: some View {
        Group {
            Button("◌") {
                Haptics.play {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                SystemSound.inputClick.play()
                inputViewController?.type(text: Symbols.dottedCircle)
            }
            Button("⟨ ⟩") {
                Haptics.play {
                    UISelectionFeedbackGenerator().selectionChanged()
                }
                SystemSound.inputClick.play()
                inputViewController?.typeSandwich(Symbols.angleBrackets)
            }
            if LocalStorage.getBool(for: SettingsKey.shouldShowAffricateTieBarsInToolbar) {
                Button("◌͡◌") {
                    Haptics.play {
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                    SystemSound.inputClick.play()
                    inputViewController?.type(text: Symbols.topTieBar)
                }
                Button("◌͜◌") {
                    Haptics.play {
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                    SystemSound.inputClick.play()
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
                        .font(.system(size: 20.0))
                }
                .foregroundColor(.primary)
                .background(Color.clearInteractable)
            }
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}
