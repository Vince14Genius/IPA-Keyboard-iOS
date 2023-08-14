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
    
    var body: some View {
        HStack(spacing: 0) {
            Button("[ ]") {
                inputViewController?.typeSandwich(Symbols.squareBrackets)
            }
            Button("/ /") {
                inputViewController?.typeSandwich(Symbols.forwardSlashes)
            }
            Button("~") {
                inputViewController?.type(text: Symbols.tilde)
            }
            Button("◌") {
                inputViewController?.type(text: Symbols.dottedCircle)
            }
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}
