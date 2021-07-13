//
//  DefaultButtonStyle.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

public struct BlueButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.system(.headline))
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .opacity(configuration.isPressed ? 0.67 : 1)
            .cornerRadius(16)
    }
}

struct DefaultButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center) {
            Button(action: {}) {
                Text("Continue")
                .padding()
            }
        }
        .padding()
        .buttonStyle(BlueButtonStyle())
    }
}
