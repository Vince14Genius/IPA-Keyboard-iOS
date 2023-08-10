//
//  BottomRow.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

private func underlayOffset(
    proxyWidth: Double,
    sectionCount: Int,
    section: Int,
    keyboardSizeClass: KeyboardSizeClass
) -> Double {
    proxyWidth / Double(sectionCount) * Double(section) - proxyWidth / 2 + BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass) / 2
}

struct BottomRow: View {
    
    static func rowHeight(keyboardSizeClass: KeyboardSizeClass) -> Double {
        keyboardSizeClass == .padRegular ? 48 : 36
    }
    
    static func buttonWidth(keyboardSizeClass: KeyboardSizeClass) -> Double {
        rowHeight(keyboardSizeClass: keyboardSizeClass)
    }
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    
    weak var inputViewController: UIInputViewController?
    var needsInputModeSwitchKey: Bool
    
    @ObservedObject var dataSource: BottomRowDataSource
    @ObservedObject var cursorGestureState: CursorGestureState
    @ObservedObject var layoutSwitcherState: LayoutSwitcherState
    
    @State private var isScrolling = false
    
    static let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)
    
    @AppStorage(SettingsKey.isInputSwitchKeyAlwaysOn, store: appGroupStorage) private var isInputSwitchKeyAlwaysOn: Bool = false
    
    static func underlayColor(colorScheme: ColorScheme) -> Color {
        .init(white: colorScheme == .light ? 0 : 1, opacity: 0.15)
    }
    
    private func isExtremelyCrowded(keyboardSizeClass: KeyboardSizeClass) -> Bool {
        keyboardSizeClass == .crowdedCompact && UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        let keyboardSizeClass = KeyboardSizeClass.from(
            sizeClass: sizeClass ?? .compact,
            rootViewController: inputViewController,
            needsInputModeSwitchKey: needsInputModeSwitchKey
        )
        
        HStack(alignment: .center, spacing: 0) {
            if keyboardSizeClass != .crowdedCompact {
                LayoutSwitcher(direction: .up, state: layoutSwitcherState, keyboardSizeClass: keyboardSizeClass)
                    .padding(.trailing, keyboardSizeClass == .padRegular ? 8 : 4)
            }
            
            if keyboardSizeClass == .padRegular {
                Spacer()
            }
            
            if
                keyboardSizeClass == .crowdedCompact,
                let inputViewController
            {
                // layout restrictions for crowded and extra-crowded size classes
                let multiplier = UIDevice.current.userInterfaceIdiom == .pad ? 3.0 : 2.0
                let maxWidth = max(0, inputViewController.view.frame.size.width - BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass) * multiplier)
                SectionScroller(isScrolling: $isScrolling, dataSource: dataSource, keyboardSizeClass: keyboardSizeClass)
                    .frame(maxWidth: maxWidth)
            } else {
                SectionScroller(isScrolling: $isScrolling, dataSource: dataSource, keyboardSizeClass: keyboardSizeClass)
            }
            
            if !isExtremelyCrowded(keyboardSizeClass: keyboardSizeClass) {
                Spacer(minLength: 0)
                BackwardsDeleteButton(inputViewController: inputViewController, keyboardSizeClass: keyboardSizeClass)
            }
        }
        .padding([.leading, .trailing], 6)
        .opacity(cursorGestureState.isMovingCursor ? CursorGestureState.movingOpacity : 1.0)
        .allowsHitTesting(!cursorGestureState.isMovingCursor)
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                let dataSource = BottomRowDataSource(sectionGlyphs: ["a", "b", "c", "1", "2", "3", "/"])
                BottomRow(needsInputModeSwitchKey: false, dataSource: dataSource, cursorGestureState: .init(), layoutSwitcherState: .init())
                    .background(Color(.secondarySystemBackground))
            }
        }
        .preferredColorScheme(.light)
    }
}
