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
                .alert(isPresented: $storeManager.isShowingAlert) {
                    // using the old alert API for iOS 14 compatibility
                    if let alert = storeManager.alert {
                        Alert(
                            title: Text({
                                switch alert {
                                case .refundAlert(_):
                                    "Refund Processed"
                                case .restoredAlert:
                                    "Purchases Restored"
                                case .restoreFailedAlert(_):
                                    "Restore Failed"
                                }
                            }()),
                            message: {
                                switch alert {
                                case .refundAlert(let message):
                                    Text(message)
                                case .restoredAlert:
                                    nil
                                case .restoreFailedAlert(let errorMessage):
                                    Text(errorMessage)
                                }
                            }()
                        )
                    } else {
                        Alert(title: Text("<error>"))
                    }
                }
        }
    }
}

struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
