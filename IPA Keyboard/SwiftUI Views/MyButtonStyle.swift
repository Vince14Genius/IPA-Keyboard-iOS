//
//  MyButtonStyle.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

public struct MyButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        MyButtonStyleView(configuration: configuration)
    }
}

private extension MyButtonStyle {
    struct MyButtonStyleView: View {
        @Environment(\.isEnabled) var isEnabled
        let configuration: MyButtonStyle.Configuration
        
        var body: some View {
        return configuration.label
            .font(Font.system(.headline))
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(Color.white)
            .background(isEnabled ? Color.accentColor : Color.gray)
            .opacity(configuration.isPressed ? 0.67 : 1)
            .cornerRadius(16)
        }
    }
}

struct MyButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center) {
            Button(action: {}) {
                Text("Continue")
                .padding()
            }
            Button(action: {}) {
                Text("Continue")
                .padding()
            }
            .disabled(true)
        }
        .padding()
        .buttonStyle(MyButtonStyle())
    }
}
