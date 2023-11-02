//
//  StorageManager.swift
//  Shopy
//
//  Created by Mohamed Adel on 02/11/2023.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

class StorageManager {
    
    static let shared = StorageManager()
    let storage = Storage.storage().reference()
    
    private init() { }
    
    func uploadImage(data: Data) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let fileRef = storage.child("image/\(uid).jpg")

        let _ = try await fileRef.putDataAsync(data)
    }
    
    
    func getImage() async throws -> Data? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let fileRef = storage.child("image/\(uid).jpg")

        return try await fileRef.data(maxSize: 8 * 1024 * 1024)
    }
    
    
    func deleteImage() async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let fileRef = storage.child("image/\(uid).jpg")

        try await fileRef.delete()
    }
    
    
}
