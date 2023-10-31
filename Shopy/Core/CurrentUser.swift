//
//  CurrentUser.swift
//  Shopy
//
//  Created by Mohamed Adel on 31/10/2023.
//

import Foundation
import FirebaseAuth

class CurrentUser: ObservableObject {
    
    @Published var isLogin = false
    
    
    init() {
        
        if Auth.auth().currentUser != nil {
            isLogin = true
        }
        
    }

}
