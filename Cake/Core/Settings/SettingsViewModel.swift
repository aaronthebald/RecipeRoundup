//
//  SettingsViewModel.swift
//  Cake
//
//  Created by Aaron Wilson on 2/20/24.
//

import Foundation
import RevenueCat
import SwiftUI
import Combine
class SettingsViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var checkingStatus: Bool = false
    
    let proAccessManager: ProAccessManager
    let subscriptionManager = SubscriptionService()
    var cancellables = Set<AnyCancellable>()
    init(proAccessManager: ProAccessManager) {
        self.proAccessManager = proAccessManager
        subscribeToError()
    }
    
    func makeSubscriptionPurchase() {
        checkingStatus = true
        subscriptionManager.purchase(productId: "rr_499_yearly") {
            self.proAccessManager.isProAccess = true
            self.checkingStatus = false
        }
    }
    
    func subscribeToError() {
        print("sub to error ran")
        subscriptionManager.$subscriptionError
            .sink { error in
                if error != nil {
                    if error?.localizedDescription == "Purchase was cancelled." {
                        self.checkingStatus = false
                    } else {
                        self.showAlert = true
                        self.errorMessage = error!.localizedDescription
                        self.checkingStatus = false
                    }
                }
            }
            .store(in: &cancellables)
        subscriptionManager.$userCanceled
            .sink { canceled in
                if canceled == true {
                    print(canceled)
                    self.checkingStatus = false
                }
            }
            .store(in: &cancellables)
    }
    
    func restorePurchase() {
        checkingStatus = true
        Purchases.shared.restorePurchases { customer, error in
            if customer?.entitlements["proaccess"]?.isActive == true {
                self.proAccessManager.isProAccess = true
                self.checkingStatus = false
            }  else if customer?.entitlements["proaccess"]?.isActive == false {
                self.checkingStatus = false
                self.showAlert = true
                self.errorMessage = "Pro Access Purchase History Not Found"
            }
            else if error != nil {
                self.checkingStatus = false
                self.showAlert = true
                guard let message = error?.localizedDescription else { return }
                self.errorMessage = message
            }
        }
    }
}
