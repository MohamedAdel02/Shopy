//
//  ProductCell.swift
//  Shopy
//
//  Created by Mohamed Adel on 22/10/2023.
//

import SwiftUI

struct ProductCell: View {
    
    var product: Product
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
            
            VStack {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(height: 150)
                    
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .frame(width:110, height: 130)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } placeholder: {
                        ProgressView()
                            .frame(height: 150)
                    }
                }
                
                HStack {
                    Text(product.title)
                        .padding(.horizontal, 5)
                        .lineLimit(2)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.text)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Text(product.price, format: .currency(code: "USD"))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .lineLimit(2)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.turquoise)
                }
                
            }
            
        }
    }
    
}


#Preview {
    ProductCell(product: MockData.product)
}

