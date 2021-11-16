//
//  StoreManager.swift
//  IPA Keyboard
//
//  Created by Vincent C. on 11/15/21.
//  Copyright © 2021 Vince14Genius. All rights reserved.
//

import StoreKit

/**
 A singleton class for managing `StoreKit` requests and transactions
 */
class StoreManager: NSObject, ObservableObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    /**
     The singleton instance of the `StoreManager` class
     */
    public static var instance: StoreManager { Self._instance }
    
    private override init() {}
    private static let _instance = StoreManager()
    
    @Published var products = [SKProduct]()
    @Published var transactionState: SKPaymentTransactionState?
    
    private let appGroupStorage = UserDefaults(suiteName: SharedIdentifiers.appGroup)
    
    var request: SKProductsRequest!
    
    func getProducts(productIDs: [String]) {
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    
    func purchaseProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        } else {
            print("User can't make payment.")
        }
    }
    
    func restoreProducts() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Request did fail: \(error)")
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
            for fetchedProduct in response.products {
                DispatchQueue.main.async {
                    self.products.append(fetchedProduct)
                }
            }
        }
        
        for invalidIdentifier in response.invalidProductIdentifiers {
            print("Invalid identifiers found: \(invalidIdentifier)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                transactionState = .purchasing
            case .purchased:
                handleNonconsumablePurchaseSuccess(transaction: transaction)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                handleNonconsumablePurchaseSuccess(transaction: transaction)
                queue.finishTransaction(transaction)
                transactionState = .restored
            case .failed, .deferred:
                print("Payment Queue Error: \(String(describing: transaction.error))")
                queue.finishTransaction(transaction)
                transactionState = .failed
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
}

fileprivate extension StoreManager {
    func handleNonconsumablePurchaseSuccess(transaction: SKPaymentTransaction) {
        if let storageKey = InAppPurchases.productIdToStorageKey[transaction.payment.productIdentifier] {
            appGroupStorage?.set(true, forKey: storageKey)
            print("Did set \(storageKey)")
        } else {
            print("Purchase did not require updating UserDefaults")
        }
    }
}
