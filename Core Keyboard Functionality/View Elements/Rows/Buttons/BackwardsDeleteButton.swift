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
    var rowsLayout: RowsLayout
    
    var body: some View {
        HoldRepeatButton(
            label: Image(systemName: "delete.left")
        ) {
            inputViewController?.deleteBackwardByOne()
            SystemSound.delete.play()
        }
        .frame(width: BottomRow.buttonWidth(rowsLayout: rowsLayout), height: BottomRow.rowHeight(rowsLayout: rowsLayout))
        .foregroundColor(Color(.label))
        .background(Color.clearInteractable)
        .buttonStyle(BackwardDeleteButtonStyle())
        .font(rowsLayout == .padRegular ? .system(size: GlyphButton.textSideLength(rowsLayout: rowsLayout) * 0.67) : .body)
    }
}
