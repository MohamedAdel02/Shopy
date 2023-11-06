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
        
        try await db.collection("users").document(uid).setData(data)
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
    
    func getCartProducts() async throws -> [CartProduct]? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let snapshot = try await db.collection("users").document(uid).collection("cart").getDocuments()

        return handleDocuments(snapshot: snapshot)
    }
    
    func handleDocuments(snapshot: QuerySnapshot) -> [CartProduct] {
        
        var products = [CartProduct]()
        
        for document in snapshot.documents {
            
            guard let id = Int(document.documentID) else {
                continue
            }
            let title = document.get("title") as? String ?? ""
            let image = document.get("image") as? String ?? ""
            let price = document.get("price") as? Double ?? 0.0
            let quantity = document.get("quantity") as? Int ?? 1
            let sizeString = document.get("size") as? String
            var size: Size?
            
            switch sizeString {
            case "S":
                size = .small
            case "M":
                size = .medium
            case "L":
                size = .large
            case "XL":
                size = .xLarge
            case "XXL":
                size = .xxLarge
            case .none:
                break
            case .some(_):
                break
            }
            
            let product = CartProduct(id: id, title: title, image: image, price: price, size: size, quantity: quantity)
            
            products.append(product)
        }
        
        return products
        
    }
    
    func updateCartProduct(product: CartProduct) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data: [String: Any] = [
            "title": product.title,
            "image": product.image,
            "price": product.price,
            "size": product.size?.rawValue as Any,
            "quantity": product.quantity
        ]
        
        try await db.collection("users").document(uid).collection("cart").document("\(product.id)").setData(data)
    }
    
    func deleteCartProduct(id: Int) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        try await db.collection("users").document(uid).collection("cart").document("\(id)").delete()
    }
    
    func deleteAllCart(products: [CartProduct]) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        for product in products {
            try await db.collection("users").document(uid).collection("cart").document("\(product.id)").delete()
        }
        
    }
    
    
}
