//
//  KeyButtonView.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 9/16/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

class KeyButtonViewDelegate: ObservableObject {
    @Published var title: String?
    @Published var isPressed = false
    
    convenience init(title: String?) {
        self.init()
        self.title = title
    }
}

struct KeyButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let defaultKeyFontSize: CGFloat = 24
    private let complexKeyFontSize: CGFloat = 22
    
    @ObservedObject var delegate: KeyButtonViewDelegate
    
    var body: some View {
        let cornerRadius = 5.0
        if let titleText = delegate.title {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.black)
                        .offset(y: 1)
                        .opacity(colorScheme == .dark ? 1.0 : 0.3)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.white)
                }
                .compositingGroup()
                .opacity(colorScheme == .dark ? Color.darkModeKeyBackgroundOpacity : 1.0)
                Text(titleText)
                    .font(.system(size: Symbols.hasDottedCircle(titleText) ? complexKeyFontSize : defaultKeyFontSize))
                    .foregroundColor(Color(.label))
            }
            .opacity(delegate.isPressed ? 0.5 : 1.0)
            .accessibilityLabel(Symbols.removedDottedCircles(titleText))
            .accessibilityAddTraits(.isKeyboardKey)
        } else {
            Rectangle()
                .opacity(.leastNonzeroMagnitude)
                .accessibilityLabel("")
        }
    }
}

struct KeyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                VStack(spacing: 4) {
                    ForEach(0..<4) { i in
                        HStack(spacing: 4) {
                            ForEach(0..<10) { j in
                                VStack {
                                    if i == j {
                                        KeyButtonView(delegate: KeyButtonViewDelegate())
                                    } else {
                                        KeyButtonView(delegate: KeyButtonViewDelegate(title: "∅"))
                                    }
                                }
                                .frame(width: 38, height: 38)
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color(.secondarySystemBackground))
            Spacer()
        }
    }
}
