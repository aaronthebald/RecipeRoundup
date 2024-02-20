//
//  CakeApp.swift
//  Cake
//
//  Created by Aaron Wilson on 11/6/23.
//

import SwiftUI
import RevenueCat

@main
struct CakeApp: App {
    
    init() {
        setupRevenueCat()
    }
    
    var body: some Scene {
        WindowGroup {
            AllDessertsView()
        }
    }
    
    func setupRevenueCat() {
           
        Purchases.logLevel = .info
           Purchases.configure(withAPIKey: "appl_iKGCsoUbLGhgTZIPaflBimJcLgB")
       }
}
