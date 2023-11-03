//
//  User.swift
//  Shopy
//
//  Created by Mohamed Adel on 01/11/2023.
//

import Foundation

struct User {
    
    let name: String?
    let email: String?
    let country: String?
    let city: String?
    var address: String?
    
    init(name: String?, email: String?, country: String?, city: String? = nil, address: String? = nil) {
        self.name = name
        self.email = email
        self.country = country
        self.city = city
        self.address = address
    }
    
}
