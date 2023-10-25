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
    
    var body: some Scene {
        WindowGroup {
            ShopyTabView()
        }
    }
}
