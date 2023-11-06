//
//  CartListCellView.swift
//  Shopy
//
//  Created by Mohamed Adel on 29/10/2023.
//

import SwiftUI

struct CartListCellView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    let product: CartProduct
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top, spacing: 15) {
                
                VStack {
                    productImage
                    productQuantity
                }
                
                VStack(alignment: .leading) {
                    productInfo
                    Spacer()
                    productTotalPrice
                }
            }
            .padding(.horizontal, 15)
            
            HStack {
                Spacer()
                deleteButton
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            
            Line()
        }
    }
    
}

#Preview {
    CartListCellView(product: MockData.cartProduct)
}


extension CartListCellView {
    
    var productImage: some View {

        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
                .frame(width: 140, height: 150)
            
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .frame(width:110, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } placeholder: {
                ProgressView()
                    .frame(height: 150)
            }
        }
        .padding(.bottom)
        
    }
    
    
    var productQuantity: some View {
        
        HStack {
            
            Button(action: {
                cartViewModel.quantityDecreased(id: product.id)
            }, label: {
                Text("-")
                    .frame(width: 35, height: 35)
                    .background(product.quantity == 1 ? Color.init(uiColor: .systemGray3) : Color.init(uiColor: .systemGray5))
                    .foregroundStyle(Color.text)
            })
            .disabled(product.quantity == 1)
            
            Text(product.quantity, format: .number)
                .foregroundStyle(Color.text)
                .frame(width: 25)
            
            Button(action: {
                cartViewModel.quantityIncreased(id: product.id)
            }, label: {
                Text("+")
                    .frame(width: 35, height: 35)
                    .background(product.quantity == 10 ? Color.init(uiColor: .systemGray3) : Color.init(uiColor: .systemGray5))
                    .foregroundStyle(Color.text)
            })
            .disabled(product.quantity == 10)
            
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
        
    }
    
    var productInfo: some View {
        VStack(alignment: .leading) {
            Text(product.title)
                .font(.headline)
                .foregroundStyle(Color.text)
                .fontWeight(.semibold)
                .padding(.vertical, 10)
            
            Text("In Stock")
                .foregroundStyle(Color.green)
                .fontWeight(.semibold)
            
            if let size = product.size {
                
                Text("Size: \(size.rawValue)")
                    .foregroundStyle(Color.text)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var productTotalPrice: some View {
        
        Text(product.totalPrice, format: .currency(code: "USD"))
            .font(.title2)
            .foregroundStyle(Color.text)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var deleteButton: some View {
        
        Button(action: {
            withAnimation(.easeIn) {
                cartViewModel.deletePressed(id: product.id)
            }
        }, label: {
            Text("Delete")
                .font(.headline)
                .frame(width: 100, height: 30)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        })
        
    }
    
}

