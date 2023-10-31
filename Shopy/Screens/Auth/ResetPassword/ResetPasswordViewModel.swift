//
//  ResetPasswordViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var alertIsPresented = false
    var alertTitle = ""
    var alertMessage = ""
    
    func sendPressed() {
        
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isEmpty(email: email) {
            return
        }
        
        if !isValidEmail(email: email) {
            return
        }
        
        resetPassword(email: email)
        
    }
    
    func isEmpty(email:String) -> Bool{
        
        if email.isEmpty {
            alertTitle = "Empty field"
            alertMessage = "Please enter your email"
            
            alertIsPresented = true
            return true
        }
        return false
    }
    
    
    func isValidEmail(email: String) -> Bool {
        
        if !email.isValidEmail() {
            alertTitle = "Invalid email"
            alertMessage = "Please enter a valid email"
            
            alertIsPresented = true
            return false
        }
        return true
    }
    
    func resetPassword(email: String) {
        
        Task {
            do {
                try await AuthManager.shared.resetPassword(email: email)
                await MainActor.run {
                    checkYourEmail()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func checkYourEmail() {
        
        alertTitle = "Check your email"
        alertMessage = "We sent a reset password link to your email"
        alertIsPresented = true
    }
    
}
