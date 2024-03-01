//
//  SettingsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 2/20/24.
//

import Foundation
import RevenueCat
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var checkingStatus: Bool = false
    
    let proAccessManager: ProAccessManager
    
    init(proAccessManager: ProAccessManager) {
        self.proAccessManager = proAccessManager
    }
    
    func makeSubscriptionPurchase() {
        checkingStatus = true
        SubscriptionService.purchase(productId: "rr_499_yearly") {
            self.proAccessManager.isProAccess = true
            self.checkingStatus = false
        }
    }
    
    func restorePurchase() {
        checkingStatus = true
        Purchases.shared.restorePurchases { customer, error in
            if customer?.entitlements["proaccess"]?.isActive == true {
                print("pro access checked")
                self.proAccessManager.isProAccess = true
                self.checkingStatus = false
            } else if error != nil {
                self.checkingStatus = false
                self.showAlert = true
                guard let message = error?.localizedDescription else { return }
                self.errorMessage = message
            }
        }
    }
}
