//
//  AuthManager.swift
//  Shopy
//
//  Created by Mohamed Adel on 23/10/2023.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    private init() { }
    
    func createAccount(email: String, password: String, name: String, country: String) async throws {
        
        try await Auth.auth().createUser(withEmail: email, password: password)
    
        try await FirestoreManager.shared.addUerInfo(name: name, country: country)
    }
    
    
    func login(email: String, password: String) async throws {
        
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    
    func resetPassword(email: String) async throws {
        
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func resetPassword(currentPassword: String, newPassword: String) async throws {
        
        guard let user = Auth.auth().currentUser, let email = user.email else {
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        try await Auth.auth().currentUser?.reauthenticate(with: credential)
        try await user.updatePassword(to: newPassword)
    }
    
    func logout() throws {
        
        try Auth.auth().signOut()
    }
    
    
    func deleteUser(password: String) async throws {
        
        guard let user = Auth.auth().currentUser, let email = user.email else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await Auth.auth().currentUser?.reauthenticate(with: credential)
        try await user.delete()
    }
    
}
