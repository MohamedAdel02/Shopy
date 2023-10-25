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
    
}
