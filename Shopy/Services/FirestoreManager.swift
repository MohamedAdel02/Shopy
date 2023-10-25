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
    
    func addUerInfo(name: String, country: String) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data = [
            "name": name,
            "country": country,
        ]
        
        try await db.collection("users").document(uid).setData(data)
    }
    
}
