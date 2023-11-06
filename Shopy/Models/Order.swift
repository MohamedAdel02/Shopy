//
//  Order.swift
//  Shopy
//
//  Created by Mohamed Adel on 06/11/2023.
//

import Foundation

struct Order: Identifiable {
    let id: String
    let products: [CartProduct]
    let price: Double
    let address: String
    let orderedOn: String?
    
}
