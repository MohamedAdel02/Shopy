//
//  FirestoreManager.swift
//  Shopy
//
//  Created by Mohamed Adel on 24/10/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() { }
    
    func updateUerInfo(user: User) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data: [String: Any] = [
            "name": user.name ?? "",
            "email": user.email ?? "",
            "country": user.country ?? "",
            "city": user.city ?? "",
            "address": user.address ?? ""
        ]
        
        try await db.collection("users").document(uid).updateData(data)
    }
    
    func updateUserAddress(address: String) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data: [String: Any] = [
            "address": address
        ]
        
        try await db.collection("users").document(uid).updateData(data)
    }
    
    func getUserInfo() async throws -> User? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let snapshot = try await db.collection("users").document(uid).getDocument()
        
        let name = snapshot.get("name") as? String
        let email = snapshot.get("email") as? String
        let country = snapshot.get("country") as? String
        let city = snapshot.get("city") as? String
        let address = snapshot.get("address") as? String

        return User(name: name, email: email, country: country, city: city, address: address)

    }
    
    
    func deleteUser(uid: String) async throws {

        try await db.collection("users").document(uid).delete()                  
    }
    
}
