//
//  ProductHList.swift
//  Shopy
//
//  Created by Mohamed Adel on 25/10/2023.
//

import SwiftUI

struct ProductHList: View {
    
    var products = [Product]()
    
    var body: some View {
        
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(products.prefix(4)) { product in
                    
                    NavigationLink {
                        ProductDetailsView(productID: product.id)
                    } label: {
                        ProductCell(product: product)
                            .frame(width: 150)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    
                }
            }
            .padding(.horizontal, 3)
            .padding(.bottom, 10)
            
        }
        .scrollIndicators(.hidden)
        .frame(height: 250)
        
    }
}

#Preview {
    ProductHList()
}
