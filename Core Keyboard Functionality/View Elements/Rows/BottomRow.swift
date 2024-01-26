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
        keyboardSizeClass.isWide ? 48 : 36
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
    
    var body: some View {
        let keyboardSizeClass = KeyboardSizeClass.from(
            sizeClass: sizeClass ?? .compact,
            rootViewController: inputViewController,
            needsInputModeSwitchKey: needsInputModeSwitchKey
        )
        
        HStack(alignment: .center, spacing: 0) {
            if !keyboardSizeClass.isCrowded {
                LayoutSwitcher(direction: .up, state: layoutSwitcherState, keyboardSizeClass: keyboardSizeClass)
                    .padding(.trailing, keyboardSizeClass.isWide ? 8 : 4)
            }
            
            if keyboardSizeClass.isWide {
                Spacer()
            }
            
            SectionScroller(isScrolling: $isScrolling, dataSource: dataSource, keyboardSizeClass: keyboardSizeClass)
            
            if !keyboardSizeClass.isExtraCrowded {
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
                let sampleGlyphs = ["a", "b", "c", "1", "2", "3", "/"]
                let dataSource = BottomRowDataSource(
                    sectionGlyphs: sampleGlyphs,
                    sectionAccessibilityLabels: sampleGlyphs.map { "section \($0)" }
                )
                BottomRow(needsInputModeSwitchKey: false, dataSource: dataSource, cursorGestureState: .init(), layoutSwitcherState: .init())
                    .background(Color(.secondarySystemBackground))
            }
        }
        .preferredColorScheme(.light)
    }
}
