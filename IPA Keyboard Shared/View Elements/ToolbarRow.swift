//
//  ToolbarRow.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct ToolbarRow: View {
    static let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)
    
    @AppStorage(SettingsKey.isMovableCursorEnabled, store: Self.appGroupStorage) private var isMovableCursorOn = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var inputViewController: UIInputViewController?
    
    var body: some View {
        VStack(spacing: 0) {
            if isMovableCursorOn {
                HStack(spacing: 2) {
                    Button("←") {
                        inputViewController?.moveCursorBackByOne()
                        playSystemKeySound()
                    }
                    Button("→") {
                        inputViewController?.moveCursorForwardByOne()
                        playSystemKeySound()
                    }
                }
                .buttonStyle(CursorButtonStyle())
                .padding(4)
                
                Divider()
            }
            
            HStack(spacing: 24) {
                Button("[ ]") {
                    inputViewController?.insertText(GlobalSymbols.squareBrackets)
                    inputViewController?.moveCursorBackByOne()
                    playSystemKeySound()
                }
                Button("/ /") {
                    inputViewController?.insertText(GlobalSymbols.forwardSlashes)
                    inputViewController?.moveCursorBackByOne()
                    playSystemKeySound()
                }
                Button("~") {
                    inputViewController?.insertText(GlobalSymbols.tilde)
                    playSystemKeySound()
                }
                Button("◌") {
                    inputViewController?.insertText(GlobalSymbols.dottedCircle)
                    playSystemKeySound()
                }
                Spacer()
                Button("SpaceBarText") {
                    inputViewController?.insertText(" ")
                    playSystemKeySound()
                }
                Button("⏎") {
                    inputViewController?.insertText("\n")
                    playSystemKeySound()
                }
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .buttonStyle(ToolbarButtonStyle())
    }
}

struct ToolbarRow_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRow()
            .preferredColorScheme(.dark)
    }
}

