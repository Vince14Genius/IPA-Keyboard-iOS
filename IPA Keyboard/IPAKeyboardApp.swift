//
//  IPAKeyboardApp.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 4/7/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

@main
struct IPAKeyboardApp: App {
    init() {
        LocalStorage.setDefaultValues()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    SKPaymentQueue.default().add(StoreManager.instance)
                }
        }
    }
}

struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
