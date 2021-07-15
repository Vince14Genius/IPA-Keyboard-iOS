//
//  View+makeStackNavigationPage.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 7/14/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI

extension View {
    func makeStackNavigationPage() -> some View {
        NavigationView {
            self
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
