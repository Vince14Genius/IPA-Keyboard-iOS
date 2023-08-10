//
//  ToolbarRow.swift
//  IPA Keyboard Extension
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

private let cursorThreshold = 2.0

struct ToolbarRow: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var cursorGestureState: CursorGestureState
    @ObservedObject var layoutSwitcherState: LayoutSwitcherState
    
    @State private var previousCursorTranslation: Double?
    @State private var cursorDeltaBuildup = 0.0
    
    static let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)
    
    @AppStorage(SettingsKey.isInputSwitchKeyAlwaysOn, store: appGroupStorage) private var isInputSwitchKeyAlwaysOn: Bool = false
    
    weak var inputViewController: UIInputViewController?
    
    var body: some View {
        let keyboardSizeClass = KeyboardSizeClass.from(
            sizeClass: sizeClass ?? .compact,
            rootViewController: inputViewController,
            needsInputModeSwitchKey: inputViewController?.needsInputModeSwitchKey ?? true
        )
        
        VStack(spacing: 0) {
            if keyboardSizeClass == .crowdedCompact {
                HStack {
                    LayoutSwitcher(direction: .down, state: layoutSwitcherState, keyboardSizeClass: keyboardSizeClass)
                        .padding(4)
                        .padding([.leading, .trailing], 6)
                    Spacer()
                }
                Divider()
            }
            
            HStack(spacing: 0) {
                PinnedSymbolKeys(
                    inputViewController: inputViewController
                )
                
                if keyboardSizeClass == .crowdedCompact {
                    Spacer(minLength: 0)
                } else {
                    Spacer()
                }
                
                PinnedGeneralKeys(
                    cursorGestureState: cursorGestureState,
                    inputViewController: inputViewController
                )
            }
            .padding([.leading, .trailing], 6)
            .opacity(cursorGestureState.isMovingCursor ? CursorGestureState.movingOpacity : 1.0)
            .allowsHitTesting(!cursorGestureState.isMovingCursor)
        }
    }
}

struct ToolbarRow_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarRow(cursorGestureState: .init(), layoutSwitcherState: .init())
    }
}

