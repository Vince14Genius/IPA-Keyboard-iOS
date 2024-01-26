//
//  SectionScroller.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/31/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

private struct GlyphWithID: Identifiable {
    var glyph: String
    var id: Int
}

struct SectionScroller: View {
    @Binding var isScrolling: Bool
    @ObservedObject var dataSource: BottomRowDataSource
    let keyboardSizeClass: KeyboardSizeClass
    
    @Environment(\.colorScheme) var colorScheme
    
    private func underlayOffset(
        proxyWidth: Double,
        sectionCount: Int,
        section: Int
    ) -> Double {
        let buttonWidth = BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass)
        let realProxyWidth = max(proxyWidth, buttonWidth * Double(sectionCount))
        let sectionWidth = realProxyWidth / Double(sectionCount)
        let offsetFromOrigin = sectionWidth * Double(section)
        let origin = -realProxyWidth / 2
        let correctionAmount = buttonWidth / 2
        return origin + offsetFromOrigin + correctionAmount
    }
    
    private func dragScroll(x: Double, width: Double) {
        let normalized = x / width
        let scaled = normalized * Double(dataSource.sectionGlyphs.count)
    
        let section = Int(floor(scaled)) // prevent -0.x bugs
        let fraction = scaled - floor(scaled)
        
        dataSource.dragScrollAction?(section, fraction)
    }
    
    var body: some View {
        let glyphs = dataSource.sectionGlyphs.indices.map {
            GlyphWithID(
                glyph: dataSource.sectionGlyphs[$0],
                id: $0
            )
        }
        
        GeometryReader { proxy in
            ZStack {
                Group {
                    let offset = underlayOffset(
                        proxyWidth: proxy.size.width,
                        sectionCount: dataSource.sectionGlyphs.count,
                        section: dataSource.highlightedSectionIndex
                    )
                    BottomRow.underlayColor(colorScheme: colorScheme)
                        .cornerRadius(.infinity)
                        .frame(maxWidth: isScrolling ? .infinity : BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass))
                        .offset(x: isScrolling ? 0.0 : offset)
                }
                
                HStack(spacing: 0) {
                    ForEach(glyphs) { element in
                        let isSelected = element.id == dataSource.highlightedSectionIndex
                        let foregroundColor = (isSelected || isScrolling) ? Color(.label) : Color(.secondaryLabel)
                        
                        GlyphButton(
                            label: Text(dataSource.sectionGlyphs[element.id]),
                            foregroundColor: foregroundColor,
                            keyboardSizeClass: keyboardSizeClass
                        ) {
                            Haptics.play {
                                UISelectionFeedbackGenerator().selectionChanged()
                            }
                            SystemSound.playInputClick()
                            dataSource.sectionIconTapAction?(element.id)
                        }
                        .accessibilityLabel(dataSource.sectionAccessibilityLabels[element.id])
                        .accessibilityAddTraits(.isButton)
                        Spacer(minLength: 0)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .background(Color.clearInteractable)
            .animation(.easeInOut(duration: 0.3), value: isScrolling)
            .gesture(
                DragGesture(minimumDistance: 1)
                    .onChanged { value in
                        isScrolling = true
                        dragScroll(x: value.location.x, width: proxy.size.width)
                    }
                    .onEnded { _ in
                        isScrolling = false
                    }
            )
            .onChange(of: dataSource.highlightedSectionIndex) { _ in
                if isScrolling {
                    Haptics.play {
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                }
            }
        }
        .frame(height: BottomRow.rowHeight(keyboardSizeClass: keyboardSizeClass))
        .frame(maxWidth: Double(glyphs.count) * BottomRow.buttonWidth(keyboardSizeClass: keyboardSizeClass) * 2)
    }
}
