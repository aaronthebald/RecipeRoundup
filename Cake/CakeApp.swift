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
    
    @StateObject var proAccessManager = ProAccessManager()
    
    init() {
        setupRevenueCat()
    }
    
    var body: some Scene {
        WindowGroup {
            ItemsListView()
                .environmentObject(proAccessManager)
        }
        
    }
    
    func setupRevenueCat() {
           
        Purchases.logLevel = .info
           Purchases.configure(withAPIKey: "appl_iKGCsoUbLGhgTZIPaflBimJcLgB")
       }
}
