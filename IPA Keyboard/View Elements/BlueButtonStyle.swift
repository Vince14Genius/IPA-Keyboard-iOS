//
//  BlueButtonStyle.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

public struct BlueButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        if #available(iOS 26.0, *) {
            configuration.label
                .font(.body.weight(.semibold))
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .padding()
                .glassEffect(.regular.tint(.blue).interactive())
        } else {
            // Fallback on earlier versions
            configuration.label
                .font(.body.weight(.semibold))
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.blue)
                .opacity(configuration.isPressed ? 0.67 : 1)
                .cornerRadius(.infinity)
                .padding([.leading, .trailing], 8)
        }
    }
}

struct BlueButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center) {
            Button(action: {}) {
                Text("Continue")
            }
        }
        .padding()
        .buttonStyle(BlueButtonStyle())
    }
}
