//
//  ChangePasswordViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import Foundation


class ChangePasswordViewModel: ObservableObject {
    
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var alertIsPresented = false
    var alertTitle = ""
    var alertMessage = ""
    
    func changePressed() {
        
        let currentPassword = currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if fieldsAreEmpty(currentPassword: currentPassword, newPassword: newPassword) {
            return
        }
        
        if !isValidPassword(password: newPassword) {
            return
        }
        
        changePassword(currentPassword: currentPassword, newPassword: newPassword)
        
    }
    
    func fieldsAreEmpty(currentPassword: String, newPassword: String) -> Bool {
        
        if currentPassword.isEmpty || newPassword.isEmpty {
            alertTitle = "Empty field"
            alertMessage = "Please enter all required fields"
            alertIsPresented = true
            return true
        }
        return false
    }
    
    func isValidPassword(password: String) -> Bool {
        
        if newPassword.count < 6 {
            alertTitle = "Invalid password"
            alertMessage = "Please enter a valid password"
            alertIsPresented = true
            return false
        }
        return true
    }

    func changePassword(currentPassword: String, newPassword: String) {
        
        Task {
            do {
                try await AuthManager.shared.resetPassword(currentPassword: currentPassword, newPassword: newPassword)
                await MainActor.run {
                    changingCompleted()
                }
            } catch {
                await MainActor.run {
                    wrongPassword()
                }
            }
        }
    }
    
    func changingCompleted() {
        
        alertTitle = "Your password changed successfully"
        alertMessage = ""
        alertIsPresented = true
    }
    
    func wrongPassword() {
        
        alertTitle = "Wrong password"
        alertMessage = "Please enter the correct password"
        alertIsPresented = true
    }
    
}
