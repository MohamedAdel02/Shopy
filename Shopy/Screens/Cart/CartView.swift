//
//  CartView.swift
//  Shopy
//
//  Created by Mohamed Adel on 17/10/2023.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if cartViewModel.cartProducts.isEmpty {
                    emptyCartView
                } else {
                    cartListView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
        }
        .tint(Color.text)
    }
}

#Preview {
    CartView()
}


extension CartView {
    
    var emptyCartView: some View {
        
        VStack(spacing: 3) {
            
            Spacer()
            
            Image(systemName: "cart")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, 40)
                .foregroundStyle(Color.turquoise)
            
            Text("Your cart is empty")
                .font(.title2)
                .bold()
                .foregroundStyle(Color.text)
            
            Text("Looks like you haven't added anything to your cart yet")
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .foregroundStyle(Color.init(uiColor: UIColor.systemGray2))
            
            Spacer()
            
            Line()
        }
    }
    
    
    var cartListView: some View {
        
        VStack(spacing: 0) {
            ScrollView {
                VStack {
                    
                    ForEach(cartViewModel.cartProducts) { product in
                        CartListCellView(product: product)
                    }
                    
                }
                
            }
            .padding(.top)
            .scrollIndicators(.hidden)
            
            VStack {
                HStack(alignment: .bottom) {

                    totalPriceView                    
                    Spacer()
                    proccedToBuyButton
                }
                
                Line()
            }
            .padding(.top, 5)
            .background(.white)

            
        }

    }
    
    var totalPriceView: some View {
        
        VStack(alignment: .leading) {
            Text("Total")
                .font(.title3)
                .foregroundStyle(Color.text)
                .fontWeight(.semibold)
            
            
            
            Text(cartViewModel.totalPrice, format: .currency(code: "USD"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.turquoise)
        }
        .padding(.leading)
        
    }
    
    var proccedToBuyButton: some View {
        
        NavigationLink {
            DeliveryAddressView()
                .navigationTitle("Delivery Address")
        } label: {
            Text("PROCEED TO BUY")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(Color.text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .padding(.trailing)
    }
    
}

