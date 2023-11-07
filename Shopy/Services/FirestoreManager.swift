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
    
    
    func deleteUser(uid: String, products: [CartProduct], orders: [Order]) async throws {

        try await deleteAllCart(products: products)
        try await deleteAllOrders(uid: uid, orders: orders)
        try await db.collection("users").document(uid).delete()

    }
    
    func getCartProducts() async throws -> [CartProduct]? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let snapshot = try await db.collection("users").document(uid).collection("cart").getDocuments()

        return FirestoreHelper.getProducts(snapshot: snapshot)
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
    
    func getOrders() async throws -> [Order]? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let snapshot = try await db.collection("users").document(uid).collection("orders").getDocuments()

        return try await FirestoreHelper.getOrders(snapshot: snapshot)
    }
    
    func getOrderProducts(orderId: String) async throws -> [CartProduct]? {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        let snapshot = try await db.collection("users").document(uid).collection("orders").document(orderId).collection("products").getDocuments()

        return FirestoreHelper.getProducts(snapshot: snapshot)
    }

    
    func updateOrders(order: Order) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let data: [String: Any] = [
            "price": order.price,
            "address": order.address,
            "date": order.orderedOn as Any
        ]
        
        try await db.collection("users").document(uid).collection("orders").document("\(order.id)").setData(data)
        try await updateOrderProducts(uid: uid, order: order)
    }
    
    func updateOrderProducts(uid: String, order: Order) async throws {
        
        for product in order.products {
            
            let productData: [String: Any] = [
                "title": product.title,
                "image": product.image,
                "price": product.price,
                "size": product.size?.rawValue as Any,
                "quantity": product.quantity
            ]
            
            try await db.collection("users").document(uid).collection("orders").document(order.id).collection("products").document("\(product.id)").setData(productData)
        }
    }
    
    func deleteAllOrders(uid: String, orders: [Order]) async throws {
        
        for order in orders {
            try await deleteAllOrderProducts(uid: uid, orderId: order.id, products: order.products)
            try await db.collection("users").document(uid).collection("orders").document(order.id).delete()
        }
    }
    
    func deleteAllOrderProducts(uid: String, orderId: String, products: [CartProduct]) async throws {
        
        for product in products {
            try await db.collection("users").document(uid).collection("orders").document(orderId).collection("products").document("\(product.id)").delete()
        }
    }

}
