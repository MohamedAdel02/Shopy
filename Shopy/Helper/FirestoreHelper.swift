//
//  FirestoreHelper.swift
//  Shopy
//
//  Created by Mohamed Adel on 07/11/2023.
//

import Foundation
import FirebaseFirestore


class FirestoreHelper {
    
    static func getProducts(snapshot: QuerySnapshot) -> [CartProduct] {
        
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
    
    
    static func getOrders(snapshot: QuerySnapshot) async throws -> [Order] {
        
        var orders = [Order]()
        
        for document in snapshot.documents {
            
            let id = document.documentID
            
            let price = document.get("price") as? Double ?? 0.0
            let address = document.get("address") as? String ?? ""
            let date = document.get("date") as? String

            let products = try await FirestoreManager.shared.getOrderProducts(orderId: id) ?? [CartProduct]()
            
            let order = Order(id: id, products: products, price: price, address: address, orderedOn: date)
            orders.append(order)
        }
        
        return orders
    }
    

}
