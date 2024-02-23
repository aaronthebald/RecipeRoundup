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
    
    @EnvironmentObject private var proAccessManager: ProAccessManager
    
    func makeSubscriptionPurchase() {
        SubscriptionService.purchase(productId: "rr_499_yearly") {
            self.proAccessManager.isProAccess = true
        }
    }
}
