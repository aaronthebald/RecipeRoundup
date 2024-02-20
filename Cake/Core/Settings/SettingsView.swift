//
//  SettingsView.swift
//  Cake
//
//  Created by Aaron Wilson on 2/20/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                    
                Link(destination: URL(string: "https://github.com/aaronthebald/Cake/blob/main/PrivacyPolicy")!, label: {
                    Text("Privacy Policy")
                })
            }
        }
    }
}

#Preview {
    SettingsView()
}
