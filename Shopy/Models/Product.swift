//
//  Product.swift
//  Shopy
//
//  Created by Mohamed Adel on 19/10/2023.
//

import Foundation

struct Product: Codable, Identifiable {
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
}

struct Rating: Codable {
    
    let rate: Double
    let count: Int
}

extension Product: Hashable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id);
    }
    
}


