//
//  ProductSize.swift
//  Shopy
//
//  Created by Mohamed Adel on 26/10/2023.
//

import Foundation


enum Size: String {
    case small = "S"
    case medium = "M"
    case large = "L"
    case xLarge = "XL"
    case xxLarge = "XXL"
}

struct ProductSize: Identifiable {
    let id: Int
    let availableSizes: [Size]
}

struct SizeMockData {
    
    static var availabeSizes: [ProductSize] = [
        ProductSize(id: 2, availableSizes: [.small, .large, .xxLarge]),
        ProductSize(id: 3, availableSizes: [.large, .xLarge, .xxLarge]),
        ProductSize(id: 4, availableSizes: [.small, .medium, .xLarge, .xxLarge]),
        ProductSize(id: 15, availableSizes: [.small, .medium, .large, .xLarge, .xxLarge]),
        ProductSize(id: 16, availableSizes: [.small, .large, .xxLarge]),
        ProductSize(id: 17, availableSizes: [.medium, .large, .xxLarge]),
        ProductSize(id: 18, availableSizes: [.medium, .large, .xLarge, .xxLarge]),
        ProductSize(id: 19, availableSizes: [.small, .medium, .large, .xxLarge]),
        ProductSize(id: 20, availableSizes: [.small, .large, .xLarge, .xxLarge])
    ]
}
