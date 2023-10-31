//
//  ViewExtension.swift
//  Shopy
//
//  Created by Mohamed Adel on 31/10/2023.
//

import Foundation
import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
