//
//  ShopyTabView.swift
//  Shopy
//
//  Created by Mohamed Adel on 17/10/2023.
//

import SwiftUI

struct ShopyTabView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CartView()
                .tabItem {
                    Label("Cart" , systemImage: "cart")
                }
            
            AccountView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
        }
        
    }
}

#Preview {
    ShopyTabView()
}
