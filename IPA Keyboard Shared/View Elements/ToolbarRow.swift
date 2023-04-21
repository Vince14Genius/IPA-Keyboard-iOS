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
    
    private func typeSandwich(_ text: String) {
        inputViewController?.insertText(text)
        inputViewController?.moveCursorBackByOne()
        SystemSound.playInputClick()
    }
    
    private func type(text: String) {
        inputViewController?.insertText(text)
        SystemSound.playInputClick()
    }
    
    var body: some View {
        let inputVC = inputViewController
        
        VStack(spacing: 0) {
            if isMovableCursorOn {
                HStack(spacing: 2) {
                    HoldRepeatButton(label: Image(systemName: "arrow.backward")) {
                        inputVC?.moveCursorBackByOne()
                    }
                    HoldRepeatButton(label: Image(systemName: "arrow.forward")) {
                        inputVC?.moveCursorForwardByOne()
                    }
                }
                .buttonStyle(CursorButtonStyle())
                .padding(4)
                
                Divider()
            }
            
            HStack(spacing: 0) {
                Button("[ ]") {
                    typeSandwich(Symbols.squareBrackets)
                }
                Button("/ /") {
                    typeSandwich(Symbols.forwardSlashes)
                }
                Button("~") {
                    type(text: Symbols.tilde)
                }
                Button("◌") {
                    type(text: Symbols.dottedCircle)
                }
                Spacer()
                Button("SpaceBarText") {
                    type(text: " ")
                }
                Button("⏎") {
                    type(text: "\n")
                }
            }
            .padding([.leading, .trailing], 6)
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}

struct ToolbarRow_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRow()
    }
}

