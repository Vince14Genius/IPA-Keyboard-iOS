//
//  FakeKeyCollection.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/30/23.
//  Copyright © 2023 Vince14Genius. All rights reserved.
//

import SwiftUI

private struct FakeKeyButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(" ")
            .foregroundColor(Color(.label))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .dark ? Color.darkModeKeyBackground : Color(.tertiarySystemBackground))
            .cornerRadius(4)
            .opacity(0.5)
    }
}

struct FakeKeyCollection: View {
    @ObservedObject var cursorGestureState: CursorGestureState
    
    var body: some View {
        VStack(spacing: 0) {
            Text(" ")
                .foregroundColor(Color(.tertiaryLabel))
            VStack(spacing: Layout.minimumInteritemSpacing) {
                ForEach(0 ..< Layout.cellsPerColumn, id: \.self) { i in
                    HStack(spacing: Layout.minimumLineSpacing) {
                        ForEach(0 ..< 40) { j in
                            VStack {
                                FakeKeyButton()
                            }
                            .frame(width: Layout.cellSize, height: Layout.cellSize)
                        }
                    }
                }
            }
            .padding(2)
        }
        .allowsHitTesting(false)
        .padding(.top, 2)
        .padding(.bottom, 6)
        .opacity(cursorGestureState.isMovingCursor ? 1.0 : 0.0)
    }
}

struct FakeKeyCollection_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            FakeKeyCollection(cursorGestureState: .init())
            Spacer()
        }
        .background(Color(.secondarySystemBackground))
    }
}
