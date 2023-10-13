//
//  PurchaseManager.swift
//  Zuma
//
//  Created by Adrian Martushev on 7/3/23.
//


import Foundation
import StoreKit
import Firebase
import FirebaseAuth
import FirebaseCore

@MainActor
class PurchaseManager: ObservableObject {
    #if DEBUG
        let certificate = "StoreKitTestCertificate"
    #else
        let certificate = "AppleIncRootCertificate"
    #endif
    
    let productIds = ["zuma_yearly", "zuma_monthly", "zuma_quarterly"]

    @Published
    private(set) var products: [Product] = []
    private var productsLoaded = false

    private var updates: Task<Void, Never>? = nil

    init() {
        updates = observeTransactionUpdates()
    }

    deinit {
        updates?.cancel()
    }
    
    func loadProducts() async throws {
        guard !self.productsLoaded else { return }
        self.products = try await Product.products(for: productIds)
        self.productsLoaded = true
    }

    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()

        switch result {
        case let .success(.verified(transaction)):
            // Successful purhcase
            await transaction.finish()

            await self.updatePurchasedProducts()
            
        case let .success(.unverified(_, error)):
            // Successful purchase but transaction/receipt can't be verified
            // Could be a jailbroken phone
            break
        case .pending:
            // Transaction waiting on SCA (Strong Customer Authentication) or
            // approval from Ask to Buy
            break
        case .userCancelled:
            // ^^^
            break
        @unknown default:
            break
        }
    }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
        Task(priority: .background) { [unowned self] in
            for await verificationResult in Transaction.updates {
                // Using verificationResult directly would be better
                // but this way works for this tutorial
                await self.updatePurchasedProducts()
            }
        }
    }
    
    
    @Published
    private(set) var purchasedProductIDs = Set<String>()

    var hasUnlockedPro: Bool {
       return !self.purchasedProductIDs.isEmpty
    }

    func updatePurchasedProducts() async {
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                continue
            }
            
            let currentUser = Auth.auth().currentUser
            let currentUserID = currentUser?.uid ?? ""
            if currentUserID != "" {
                let userRef = database.collection("users").document(currentUser!.uid)

                userRef.updateData([
                    "subscriptionTerm": transaction.productID
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }

            if transaction.revocationDate == nil {
                self.purchasedProductIDs.insert(transaction.productID)
            } else {
                self.purchasedProductIDs.remove(transaction.productID)
            }
        }
    }
}
