//
//  SpaceKeyWithCursorControl.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

struct SpaceKeyWithCursorControl: View {
    
    private let cursorThreshold = 2.0
    
    @ObservedObject var cursorGestureState: CursorGestureState
    @State private var previousCursorTranslation: Double?
    @State private var cursorDeltaBuildup = 0.0
    
    var inputViewController: UIInputViewController?
    
    private func moveCursorBackByOne() {
        inputViewController?.moveCursorBackByOne()
    }
    
    private func moveCursorForwardByOne() {
        inputViewController?.moveCursorForwardByOne()
    }
    
    var body: some View {
        Button {
            if cursorGestureState.isMovingCursor {
                cursorGestureState.isMovingCursor = false
            } else {
                inputViewController?.type(text: " ")
            }
        } label: {
            Group {
                if cursorGestureState.isMovingCursor {
                    Text("SpaceBarText")
                        .opacity(1.0)
                } else {
                    Text("SpaceBarText")
                }
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5).onEnded { didComplete in
                    cursorGestureState.isMovingCursor = didComplete
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred(intensity: 1.0)
            }.sequenced(
                before: DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        cursorGestureState.isMovingCursor = true
                        let currentCursorTranslation = value.translation.width
                        if let previousCursorTranslation {
                            let delta = currentCursorTranslation - previousCursorTranslation
                            cursorDeltaBuildup += delta
                        }
                        previousCursorTranslation = currentCursorTranslation
                    }
                    .onEnded { _ in
                        Timer.scheduledTimer(withTimeInterval: .leastNonzeroMagnitude, repeats: false) { _ in
                            DispatchQueue.main.async {
                                cursorGestureState.isMovingCursor = false
                            }
                        }
                    }
            )
        )
        .onChange(of: cursorGestureState.isMovingCursor) { _ in
            previousCursorTranslation = nil
            cursorDeltaBuildup = 0
        }
        .onChange(of: cursorDeltaBuildup) { newValue in
            if newValue <= -cursorThreshold {
                for _ in stride(from: newValue, to: 0, by: cursorThreshold) {
                    moveCursorBackByOne()
                }
                cursorDeltaBuildup = 0
            } else if newValue >= cursorThreshold {
                for _ in stride(from: newValue, to: 0, by: -cursorThreshold) {
                    moveCursorForwardByOne()
                }
                cursorDeltaBuildup = 0
            }
        }
    }
}
