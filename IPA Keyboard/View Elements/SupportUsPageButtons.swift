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
    var icon: Image
    var label: LocalizedStringKey
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            
            Text(label)
        }
    }
}

struct SupportUsPageButtons_Previews: PreviewProvider {
    static var previews: some View {
        SupportUsDefaultButton(icon: Image(systemName: "square.and.arrow.up"), label: "Some Label") {}
        SupportUsPage()
    }
}
