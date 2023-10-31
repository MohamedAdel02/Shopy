//
//  ProfileViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import Foundation


enum ProfileOption: String {
    case info = "Profile Info"
    case orders = "Orders"
    case changePassword = "Change Password"
    case deleteAccount = "Delete Account"
}

class ProfileViewModel: ObservableObject {
    
    @Published var profileOptions: [ProfileOption] = [.info, .orders, .changePassword, .deleteAccount]
    @Published var isLogout = false
    
    
    func logout() {
        
        do {
            try AuthManager.shared.logout()
            isLogout = true
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
