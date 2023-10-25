//
//  ProductList.swift
//  Shopy
//
//  Created by Mohamed Adel on 22/10/2023.
//

import SwiftUI

struct ProductList: View {
    
    var products = [Product]()
    var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach(products) { product in
                    
                    ProductCell(product: product)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .background(Color("backgroundColor"))
        
    }
}

#Preview {
    ProductList()
}
