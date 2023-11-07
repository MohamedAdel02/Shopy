//
//  OrderProductCell.swift
//  Shopy
//
//  Created by Mohamed Adel on 06/11/2023.
//

import SwiftUI

struct OrderProductCell: View {
    
    let product: CartProduct
    
    var body: some View {

        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.white)
                    .frame(width: 100, height: 130)
                
                AsyncImage(url: URL(string: product.image)) { image in
                    image
                        .resizable()
                        .frame(width:90, height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                } placeholder: {
                    ProgressView()
                        .frame(height: 130)
                }
            }
            
            VStack(alignment: .leading) {
                
                Text(product.title)
                    .lineLimit(2)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.text)
                    .multilineTextAlignment(.leading)
                
                Text("Quantity: \(product.quantity)")
                    .lineLimit(2)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.leading)
                
                if let size = product.size {
                    Text("Size: \(size.rawValue)")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.leading)
                }
                
                Text(product.totalPrice, format: .currency(code: "USD"))
                    .lineLimit(2)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.text)
            }
            .padding()
            
            Spacer()
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: 140)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
    
}


#Preview {
    OrderProductCell(product: MockData.cartProduct)
}
