//
//  OrderConfirmationView.swift
//  Shopy
//
//  Created by Mohamed Adel on 05/11/2023.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                VStack {
                    VStack(spacing: 15) {
                        ForEach(cartViewModel.cartProducts) { product in
                            
                            HStack(spacing: 15) {
                                
                                Text(product.title)
                                    .frame(width: geo.size.width * 0.6, alignment: .leading)
                                    .foregroundStyle(Color.text)
                                    .lineLimit(2)
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .padding()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                
                                Text("x \(product.quantity)")
                                    .foregroundStyle(Color.text)
                                    .fontWeight(.medium)
                                    .padding()
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 20)
                    
                    priceDetails
                    paymentDetails
                    addressDetails
                    confirmOrderButton
                    
                    Spacer()
                    Line()
                    
                }
                .frame(minHeight: geo.size.height)
                .background(Color.init(uiColor: .systemGray6))
            }
            .scrollIndicators(.hidden)
            
        }
        
    }
}

#Preview {
    OrderConfirmationView()
}

extension OrderConfirmationView {
    
    var priceDetails: some View {
        
        HStack(alignment: .top, spacing: 10) {
            Text("Total price: ")
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            
            Text(cartViewModel.totalPrice, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 40)
        }
        
    }
    
    var paymentDetails: some View {
        HStack(alignment: .top, spacing: 20) {
            Text("Payment: ")
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            
            Text("Cash on delivery")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 40)
        }
    }
    
    var addressDetails: some View {
        
        HStack(alignment: .top, spacing: 22) {
            Text("Address: ")
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            
            Text(cartViewModel.address)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 40)
        }
        
    }
    
    var confirmOrderButton: some View {
        
        Button(action: {
            
        }, label: {
            Text("Confirm order")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
        .padding(.vertical, 25)
    }
    
}
