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
                    GlyphButton.selectedColor(colorScheme: colorScheme)
                        .opacity(isScrolling ? 1 : 0)
                        .cornerRadius(.infinity)
                    HStack(spacing: 0) {
                        ForEach(glyphs) { element in
                            let isSelected = (element.id == dataSource.highlightedSectionIndex) && !isScrolling
                            
                            GlyphButton(
                                label: Text(dataSource.sectionGlyphs[element.id]),
                                isSelected: isSelected
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
                .gesture(
                    DragGesture(minimumDistance: 2)
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
