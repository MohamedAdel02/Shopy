//
//  CartProduct.swift
//  Shopy
//
//  Created by Mohamed Adel on 27/10/2023.
//

import Foundation

struct CartProduct: Identifiable {
    
    let id: Int
    let title: String
    let image: String
    let price: Double
    var totalPrice: Double
    let size: Size?
    var quantity: Int
    var isMaxQuantity = false
    var isMinQuantity = false
    
    init(id: Int, title: String, image: String, price: Double, size: Size?, quantity: Int) {
        self.id = id
        self.title = title
        self.image = image
        self.price = price
        self.size = size
        self.quantity = quantity
        
        totalPrice = price * Double(quantity)
                
        if quantity == 1 {
            isMinQuantity = true
        } else if quantity == 10 {
            isMaxQuantity = true
        }
    }
    
}
