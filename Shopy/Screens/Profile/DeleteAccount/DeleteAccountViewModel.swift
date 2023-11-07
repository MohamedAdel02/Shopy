//
//  DeleteAccountViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import Foundation


class DeleteAccountViewModel: ObservableObject {
    
    @Published var password = ""
    @Published var alertIsPresented = false
    @Published var isDeleted = false
    var alertTitle = ""
    var alertMessage = ""
    
    func deletePressed(products: [CartProduct], orders: [Order]) {
        
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)

        if passwordIsEmpty(password: password) {
            return
        }
        
        deleteAccount(password: password, products: products, orders: orders)
    }
    
    func passwordIsEmpty(password: String) -> Bool {
        
        if password.isEmpty {
            alertTitle = "Empty field"
            alertMessage = "Please enter all required fields"
            alertIsPresented = true
            return true
        }
        return false
    }
    
    func deleteAccount(password: String, products: [CartProduct], orders: [Order]) {
        
        Task {
            do {
                try await AuthManager.shared.deleteUser(password: password, products: products, orders: orders)
                await MainActor.run {
                    isDeleted = true
                }
            } catch {
                await MainActor.run {
                    wrongPassword()
                }
            }
            
        }
        
    }
    
    
    func wrongPassword() {
        
        alertTitle = "Wrong password"
        alertMessage = "Please enter the correct password"
        alertIsPresented = true
    }
    
}
