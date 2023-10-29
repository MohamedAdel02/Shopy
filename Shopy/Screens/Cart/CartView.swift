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
            .background(Color("backgroundColor"))
        }
    }
}

#Preview {
    CartView()
}


extension CartView {
    
    var emptyCartView: some View {
        
        VStack(spacing: 3) {
            
            Image(systemName: "cart")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, 40)
                .foregroundStyle(Color.accentColor)
            
            Text("Your cart is empty")
                .font(.title2)
                .bold()
                .foregroundStyle(Color("textColor"))
            
            Text("Looks like you haven't added anything to your cart yet")
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .foregroundStyle(Color.init(uiColor: UIColor.systemGray2))
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
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color.accentColor)
            }
            .padding(.top, 5)
            .background(.white)

            
        }

    }
    
    var totalPriceView: some View {
        
        VStack(alignment: .leading) {
            Text("Total")
                .font(.title3)
                .foregroundStyle(Color("textColor"))
                .fontWeight(.semibold)
            
            
            
            Text(cartViewModel.totalPrice, format: .currency(code: "USD"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.accentColor)
        }
        .padding(.leading)
        
    }
    
    var proccedToBuyButton: some View {
        
        Button(action: {
            
        }, label: {
            Text("PROCCED TO BUY")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(Color("textColor"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
        })
        .padding(.trailing)
    }
    
}

