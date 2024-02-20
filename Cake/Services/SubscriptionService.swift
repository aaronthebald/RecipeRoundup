//
//  SubscriptionService.swift
//  Cake
//
//  Created by Aaron Wilson on 2/20/24.
//

import Foundation
import RevenueCat
import StoreKit

class SubscriptionService {
    
    
    static func purchase(productId:String?, successfulPurchase:@escaping () -> Void) {
    
        guard productId != nil else {
            return
        }
        
        var skProduct:StoreProduct?
        
        // Find product based on Id
        Purchases.shared.getProducts([productId!]) { products in
            
            if !products.isEmpty {
                skProduct = products[0]
                
                // Purchase it
                Purchases.shared.purchase(product: skProduct!) { transation, info, error, userCancelled in
                    if error == nil && !userCancelled {
                        successfulPurchase()
                    }
                }
            }
        }
    }
    
}
