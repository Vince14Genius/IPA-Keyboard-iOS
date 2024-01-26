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
    
    @Published var isShowingAlert = false {
        didSet {
            if !isShowingAlert {
                alert = nil
            }
        }
    }
    @Published private(set) var alert: StoreManager.Alert? {
        didSet {
            if alert != nil {
                Task { @MainActor in
                    self.isShowingAlert = true
                }
            }
        }
    }
    
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
                Task { @MainActor in
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
                handlePurchaseSuccess(transaction: transaction)
                queue.finishTransaction(transaction)
                transactionState = .purchased
            case .restored:
                handlePurchaseSuccess(transaction: transaction, isRestore: true)
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
    
    func paymentQueue(_ queue: SKPaymentQueue, didRevokeEntitlementsForProductIdentifiers productIdentifiers: [String]) {
        print("paymentQueue(_:didRevokeEntitlementsForProductIdentifiers:) called")
        for id in productIdentifiers {
            if let storageKey = InAppPurchases.nonconsumableProductIdToStorageKey[id] {
                let localized = InAppPurchases.productIDToLocalizedStringKey[id] ?? "<?>"
                // Nonconsumable Products
                appGroupStorage?.set(false, forKey: storageKey)
                print("Did set \(storageKey)")
                Task { @MainActor in
                    self.alert = .refundAlert(message: "We're notified of your refund for \(localized.localized()).\nYour access to paid keyboard layouts has been updated accordingly.")
                }
            } else if let storageKey = InAppPurchases.simpleIncrementProductIdToStorageKey[id] {
                // Consumable products that are simple +1 increments
                guard let localized = InAppPurchases.productIDToLocalizedStringKey[id] else {
                    return
                }
                let oldValue = appGroupStorage?.integer(forKey: storageKey) ?? 0
                appGroupStorage?.set(oldValue - 1, forKey: storageKey)
                Task { @MainActor in
                    self.alert = .refundAlert(message: "We're notified of your refund for \(localized.localized()).\nYour contribution count has been updated accordingly.")
                }
            } else {
                print("Revokation did not require updating UserDefaults")
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        // restore failed, show error message
        Task { @MainActor in
            self.alert = .restoreFailedAlert(errorMessage: error.localizedDescription)
        }
    }
}

fileprivate extension StoreManager {
    func handlePurchaseSuccess(transaction: SKPaymentTransaction, isRestore: Bool = false) {
        if let storageKey = InAppPurchases.nonconsumableProductIdToStorageKey[transaction.payment.productIdentifier] {
            guard let appGroupStorage else { return }
            // Nonconsumable Products
            let prev = appGroupStorage.bool(forKey: storageKey)
            appGroupStorage.set(true, forKey: storageKey)
            print("Did set \(storageKey)")
            if isRestore, !prev {
                Task {
                    try await Task.sleep(nanoseconds: 400_000_000) // 0.4s
                    await MainActor.run {
                        self.alert = .restoredAlert
                    }
                }
            }
        } else if let storageKey = InAppPurchases.simpleIncrementProductIdToStorageKey[transaction.payment.productIdentifier] {
            // Consumable products that are simple +1 increments
            let oldValue = appGroupStorage?.integer(forKey: storageKey) ?? 0
            appGroupStorage?.set(oldValue + 1, forKey: storageKey)
        } else {
            print("Purchase did not require updating UserDefaults")
        }
    }
}
