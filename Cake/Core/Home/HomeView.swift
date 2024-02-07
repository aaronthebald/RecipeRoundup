//
//  HomeView.swift
//  Cake
//
//  Created by Aaron Wilson on 2/4/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            TabView(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/,
                    content:  {
                AllDessertsView()
                    .tabItem {
                        Label("Meals", systemImage: "fork.knife.circle")
                    }
                    .tag(1)
                Text("DrinksView").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
            })
        }
    }
}

#Preview {
    HomeView()
}
