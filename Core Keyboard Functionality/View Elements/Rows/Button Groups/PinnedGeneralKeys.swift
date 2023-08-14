//
//  PinnedGeneralKeys.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct PinnedGeneralKeys: View {
    @ObservedObject var cursorGestureState: CursorGestureState
    weak var inputViewController: UIInputViewController?
    
    var body: some View {
        HStack(spacing: 0) {
            SpaceKeyWithCursorControl(
                cursorGestureState: cursorGestureState,
                inputViewController: inputViewController
            )
            Button("⏎") {
                inputViewController?.type(text: "\n")
            }
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}
