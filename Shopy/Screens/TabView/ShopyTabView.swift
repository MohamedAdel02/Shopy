//
//  ShopyTabView.swift
//  Shopy
//
//  Created by Mohamed Adel on 17/10/2023.
//

import SwiftUI

struct ShopyTabView: View {
    
    @StateObject var cartViewModel = CartViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    @StateObject var popToRoot = PopToRoot()
    
    var body: some View {
        
        TabView(selection: $popToRoot.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            CartView()
                .tabItem {
                    Label("Cart" , systemImage: "cart")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(2)
            
        }
        .onReceive(popToRoot.$selectedTab) { selection in
            popToRoot.navToHome.toggle()
        }
        .environmentObject(popToRoot)
        .environmentObject(orderViewModel)
        .environmentObject(cartViewModel)
        
    }
}

#Preview {
    ShopyTabView()
}
