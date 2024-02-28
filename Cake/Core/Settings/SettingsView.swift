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
                Section("Pro Status") {
                    HStack {
                        Text("Current Status:")
                        Text(proAccessManager.isProAccess ? "Pro" : "Free")
                    }
                    if proAccessManager.isProAccess == false {
                        Text("Purchase one year of Pro Access today to save unlimted recipies to your Favorites!")
                        Button {
                            vm.makeSubscriptionPurchase()
                        }
                        label: {
                            Text("Upgrade to Pro")
                        }
                    }
                    
                    Button {
                        vm.restorePurchase()
                    } label: {
                        Text("Restore Purchase")
                    }

                }
                
                Section("Information") {
                    HStack {
                        Image("AaronWilson")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(.rect(cornerRadius: 15))
                        Text("Hello, I am Aaron.")
                    }
                    Text("I am the developer of this App. I hope you enjoy using it and make something delicious!")
                    
                    Link(destination: URL(string: "https://github.com/aaronthebald/")!) {
                        Text("Developer GitHub")
                    }
                    Link(destination: URL(string: "https://www.linkedin.com/in/aaronwilsondev/")!) {
                        Text("Developer LinkedIn")
                    }
                    Link(destination: URL(string: "https://www.themealdb.com")!) {
                        Text("themealdb.com")
                    }
                    Link(destination: URL(string: "https://www.revenuecat.com")!) {
                        Text("RevenuCat.com")
                    }
                    
                    Link(destination: URL(string: "https://github.com/aaronthebald/Cake/blob/main/PrivacyPolicy")!, label: {
                        Text("Privacy Policy")
                    })
                    Link(destination: URL(string: "https://github.com/aaronthebald/Cake/blob/main/TermsOfUse")!) {
                        Text("Terms of Use")
                    }
                }
            }
        }
    }
}
