//
//  SupportUsPageButtons.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/12/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

struct SupportUsDefaultButton: View {
    var icon: Image? = nil
    var label: LocalizedStringKey
    var isDisabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let iconView = icon {
                    iconView
                }
                Text(label)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: .infinity)
                .stroke(isDisabled ? Color.gray : Color.blue, lineWidth: 1)
        )
        .disabled(isDisabled)
        .padding(4.0)
    }
}

struct SupportUsPageButtons_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsDefaultButton(icon: Image(systemName: "square.and.arrow.up"), label: "Some Label") {}
        SupportUsPageWrapped()
    }
}
