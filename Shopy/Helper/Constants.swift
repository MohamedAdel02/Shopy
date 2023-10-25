//
//  Constants.swift
//  Shopy
//
//  Created by Mohamed Adel on 20/10/2023.
//

import Foundation



struct K {
    
    static private let baseURL = "https://fakestoreapi.com/"
    
    struct API {
        static let allProducts = "\(K.baseURL)products"
        static let categories = "\(K.baseURL)products/categories"
        static let categoryProducts = "\(K.baseURL)products/category/"
    }
    
}
