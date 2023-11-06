//
//  MockData.swift
//  Shopy
//
//  Created by Mohamed Adel on 25/10/2023.
//

import Foundation


struct MockData {
    
    static var product = Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 423, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")
    
    static var cartProduct = CartProduct(id: 1, title: "City of stars ... Are you shining just for me?", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", price: 650, size: nil, quantity: 2)
    
    static var order = Order(id: UUID().uuidString, products: [cartProduct, CartProduct(id: 2, title: "This is product", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", price: 87, size: .medium, quantity: 4)], price: 3424.43, address: "Jennifer Lawrence's house", orderedOn: "4 June 2025")
    
}
