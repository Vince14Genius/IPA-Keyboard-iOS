//
//  ToolbarRow.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct CursorButtons: View {
    var inputViewController: UIInputViewController?
    
    var body: some View {
        let inputVC = inputViewController
        
        HStack(spacing: 2) {
            HoldRepeatButton(label: Image(systemName: "arrow.backward")) {
                inputVC?.moveCursorBackByOne()
            }
            HoldRepeatButton(label: Image(systemName: "arrow.forward")) {
                inputVC?.moveCursorForwardByOne()
            }
        }
        .buttonStyle(CursorButtonStyle())
    }
}

private let cursorThreshold = 2.0

struct ToolbarRow: View {
    static let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)
    
    @AppStorage(SettingsKey.isMovableCursorEnabled, store: Self.appGroupStorage) private var isMovableCursorOn = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var cursorGestureState: CursorGestureState
    @State private var previousCursorTranslation: Double?
    @State private var cursorDeltaBuildup = 0.0
    
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
    
    private func moveCursorBackByOne() {
        inputViewController?.moveCursorBackByOne()
    }
    
    private func moveCursorForwardByOne() {
        inputViewController?.moveCursorForwardByOne()
    }
    
    var body: some View {
        let inputVC = inputViewController
        
        VStack(spacing: 0) {
            if isMovableCursorOn, UIDevice.current.userInterfaceIdiom != .pad {
                CursorButtons(inputViewController: inputVC)
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
                
                if isMovableCursorOn, UIDevice.current.userInterfaceIdiom == .pad {
                    CursorButtons(inputViewController: inputVC)
                }
                
                Button {
                    if cursorGestureState.isMovingCursor {
                        cursorGestureState.isMovingCursor = false
                    } else {
                        type(text: " ")
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
                                //TODO
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
                
                Button("⏎") {
                    type(text: "\n")
                }
            }
            .padding([.leading, .trailing], 6)
            .opacity(cursorGestureState.isMovingCursor ? CursorGestureState.movingOpacity : 1.0)
            .allowsHitTesting(!cursorGestureState.isMovingCursor)
        }
        .buttonStyle(ToolbarButtonStyle())
    }
}

struct ToolbarRow_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRow(cursorGestureState: .init())
    }
}

