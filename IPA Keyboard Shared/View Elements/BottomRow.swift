//
//  BottomRow.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/9/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

struct GlyphWithID: Identifiable {
    var glyph: String
    var id: Int
}

private func underlayOffset(
    proxyWidth: Double,
    sectionCount: Int,
    section: Int
) -> Double {
    proxyWidth / Double(sectionCount) * Double(section) - proxyWidth / 2 + BottomRow.buttonWidth / 2
}

struct BottomRow: View {
    
    static var rowHeight: Double {
        UIDevice.current.userInterfaceIdiom == .pad ? 48 : 36
    }
    
    static var buttonWidth: Double {
        rowHeight
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var inputViewController: UIInputViewController?
    
    @ObservedObject var dataSource: BottomRowDataSource
    
    @State private var isScrolling = false
    
    static func underlayColor(colorScheme: ColorScheme) -> Color {
        .init(white: colorScheme == .light ? 0 : 1, opacity: 0.15)
    }
    
    private func dragScroll(x: Double, width: Double) {
        let normalized = x / width
        let scaled = normalized * Double(dataSource.sectionGlyphs.count)
    
        let section = Int(floor(scaled)) // prevent -0.x bugs
        let fraction = scaled - floor(scaled)
        
        dataSource.dragScrollAction?(section, fraction)
    }
    
    var body: some View {
        let inputVC = inputViewController
        
        HStack(alignment: .center, spacing: 0) {
            if inputVC?.needsInputModeSwitchKey ?? false {
                Spacer(minLength: 0)
            }
            
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
                            .frame(maxWidth: isScrolling ? .infinity : BottomRow.buttonWidth)
                            .offset(x: isScrolling ? 0.0 : offset)
                    }
                    
                    HStack(spacing: 0) {
                        ForEach(glyphs) { element in
                            let isSelected = element.id == dataSource.highlightedSectionIndex
                            let foregroundColor = (isSelected || isScrolling) ? Color(.label) : Color(.secondaryLabel)
                            
                            GlyphButton(
                                label: Text(dataSource.sectionGlyphs[element.id]),
                                foregroundColor: foregroundColor
                            ) {
                                UISelectionFeedbackGenerator().selectionChanged()
                                SystemSound.playInputClick()
                                dataSource.sectionIconTapAction?(element.id)
                            }
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
                        UISelectionFeedbackGenerator().selectionChanged()
                    }
                }
            }
            .frame(height: BottomRow.rowHeight)
            
            HoldRepeatButton(label: Image(systemName: "delete.left")) {
                inputVC?.deleteBackwardByOne()
                SystemSound.delete.play()
            }
            .buttonStyle(BackwardDeleteButtonStyle())
        }
        .padding([.leading, .trailing], 6)
    }
}

struct BottomRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                let dataSource = BottomRowDataSource(sectionGlyphs: ["a", "b", "c", "1", "2", "3", "/"])
                BottomRow(dataSource: dataSource)
                    .background(Color(.secondarySystemBackground))
            }
        }
        .preferredColorScheme(.light)
    }
}
