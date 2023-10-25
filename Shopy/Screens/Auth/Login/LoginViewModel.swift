//
//  LoginViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 23/10/2023.
//

import Foundation


@MainActor class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var alertIsPresented = false
    @Published var userLogged = false
    var alertTitle = ""
    var alertMessage = ""
    
    
     func loginPressed() {
        
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines) 
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if fieldsAreEmpty(email: email, password: password) {
            return
        }

        checkLoginInfo(email: email, password: password)
    }
    
    
    func fieldsAreEmpty(email: String, password: String) -> Bool{
        
        if email.isEmpty || password.isEmpty {
            alertTitle = "Empty field"
            alertMessage = "Please enter all required fields"
            
            alertIsPresented = true
            return true
        }
        return false
    }
    
    
    func checkLoginInfo(email: String, password: String) {
        
        Task {
            do {
                try await AuthManager.shared.login(email: email, password: password)
                userLogged = true
            } catch {
                alertTitle = "Invalid email or password"
                alertIsPresented = true
            }
        }
        
    }
    
}
