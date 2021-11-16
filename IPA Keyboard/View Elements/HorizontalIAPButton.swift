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
                Text(localizedKey)
                if let product = self.product {
                    Spacer()
                    Divider()
                    Text(makeFormatter(locale: product.priceLocale).string(from: product.price)!)
                } else {
                    Spacer()
                    ProgressView()
                }
            }
        }
        .disabled(product == nil)
    }
}
