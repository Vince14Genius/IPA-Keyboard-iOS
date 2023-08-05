//
//  BackwardsDeleteButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 8/2/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct BackwardsDeleteButton: View {
    weak var inputViewController: UIInputViewController?
    var keyboardSizeClass: KeyboardSizeClass
    
    var body: some View {
        HoldRepeatButton(
            label: Image(systemName: "delete.left")
        ) {
            inputViewController?.deleteBackwardByOne()
            SystemSound.delete.play()
        }
        .frame(width: BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass), height: BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass))
        .foregroundColor(Color(.label))
        .background(Color.clearInteractable)
        .buttonStyle(BackwardDeleteButtonStyle())
        .font(keyboardSizeClass == .padRegular ? .system(size: GlyphButton.textSideLength(keyboardSizeClass: keyboardSizeClass) * 0.67) : .body)
    }
}
