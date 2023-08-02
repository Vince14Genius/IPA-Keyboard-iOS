//
//  HorizontalIAPButton.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 11/15/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import SwiftUI
import StoreKit

struct HorizontalIAPButton: View {
    let localizedKey: LocalizedStringKey
    let productIdentifier: String
    
    @ObservedObject var storeManager: StoreManager
    
    var hasDisplayLock: Bool = false
    var disabledLabel: LocalizedStringKey?
    
    var product: SKProduct? {
        storeManager.products.first { $0.productIdentifier == productIdentifier }
    }
    
    func makeFormatter(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter
    }
    
    var body: some View {
        Button {
            if let product = self.product {
                storeManager.purchaseProduct(product: product)
            }
        } label: {
            HStack {
                if hasDisplayLock {
                    Label(localizedKey, systemImage: "lock.fill")
                } else {
                    Text(localizedKey)
                }
                
                Spacer()
                
                if let disabledLabel = disabledLabel {
                    Divider()
                    Text(disabledLabel)
                } else if let product = self.product {
                    Divider()
                    Text(makeFormatter(locale: product.priceLocale).string(from: product.price)!)
                } else {
                    ProgressView()
                }
            }
        }
        .disabled(disabledLabel != nil || product == nil)
    }
}
