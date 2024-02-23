//
//  SettingsView.swift
//  Cake
//
//  Created by Aaron Wilson on 2/20/24.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var vm: SettingsViewModel
    let proAccessManager: ProAccessManager
//    _vm = StateObject(wrappedValue: DessertDetailsViewModel(dataService: dataService, favoriteService: favoriteService, proAccessManager: proAccessManager))
    init(proAccessManager: ProAccessManager) {
        _vm = StateObject(wrappedValue: SettingsViewModel(proAccessManager: proAccessManager))
        self.proAccessManager = proAccessManager
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                HStack {
                    Text("Current Status:")
                    Text(proAccessManager.isProAccess ? "Pro" : "Free")
                } 
                if proAccessManager.isProAccess == false {
                    Button {
                        vm.makeSubscriptionPurchase()
                    }
                    label: {
                        Text("Upgrade to pro")
                    }
                }
                Link(destination: URL(string: "https://github.com/aaronthebald/Cake/blob/main/PrivacyPolicy")!, label: {
                    Text("Privacy Policy")
                })
            }
        }
    }
}
