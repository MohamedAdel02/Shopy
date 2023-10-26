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
    
    @EnvironmentObject var popToRoot: PopToRoot
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                
                ForEach(products) { product in
                    
                    NavigationLink {
                        ProductDetailsView(productID: product.id)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        ProductCell(product: product)
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .background(Color("backgroundColor"))
        .onChange(of: popToRoot.navToHome) {
            dismiss()
        }
        
    }
}

#Preview {
    ProductList()
}
