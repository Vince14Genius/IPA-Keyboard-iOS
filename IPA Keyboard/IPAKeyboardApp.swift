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
    @StateObject private var storeManager = StoreManager.instance
    
    init() {
        LocalStorage.setDefaultValues()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    SKPaymentQueue.default().add(StoreManager.instance)
                }
                .alert(isPresented: $storeManager.isShowingRefundAlert) {
                    Alert(
                        title: Text("Refund Processed"),
                        message: Text(storeManager.refundMessage ?? "<error>")
                    )
                }
        }
    }
}

struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
