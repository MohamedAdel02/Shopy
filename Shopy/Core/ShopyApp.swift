//
//  ShopyApp.swift
//  Shopy
//
//  Created by Mohamed Adel on 16/10/2023.
//

import SwiftUI

@main
struct ShopyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var currentUser = CurrentUser()
    
    var body: some Scene {
        WindowGroup {
            
            ZStack {
                
                AuthMainView()
                
                if currentUser.isLogin {
                    ShopyTabView()
                }
                
            }
            .environmentObject(currentUser)
            
        }
        
    }
    
}

