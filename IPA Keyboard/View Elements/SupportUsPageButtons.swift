//
//  SupportUsPageButtons.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

struct SupportUsButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        SupportUsButtonStyleView(configuration: configuration)
    }
}

struct SupportUsButtonStyleView: View {
    @Environment(\.isEnabled) var isEnabled
    let configuration: SupportUsButtonStyle.Configuration
    
    var body: some View {
        configuration.label
            .padding()
            .foregroundColor(isEnabled ? .accentColor : .gray)
            .overlay(
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(isEnabled ? Color.accentColor : Color.gray, lineWidth: 1)
            )
            .opacity(configuration.isPressed ? 0.33 : 1)
            .disabled(!isEnabled)
            .padding(4.0)
    }
}

struct SupportUsPageButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button {} label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Some Button")
                }
            }
            
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                HStack {
                    Image(systemName: "link")
                    Text("Some Link")
                }
            }
        }
        .buttonStyle(SupportUsButtonStyle())
        
        SupportUsPageWrapped()
    }
}
