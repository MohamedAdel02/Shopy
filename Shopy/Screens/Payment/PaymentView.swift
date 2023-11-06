//
//  PaymentView.swift
//  Shopy
//
//  Created by Mohamed Adel on 05/11/2023.
//

import SwiftUI

struct PaymentView: View {
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
            
            cashOnDelivery
            creditCard
            continueButton
            
            Spacer()
            
            Line()
            
        }
        .background(Color.init(uiColor: .systemGray6))
    }
}

#Preview {
    PaymentView(rootIsActive: .constant(false))
}

extension PaymentView {
    
    var cashOnDelivery: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                Text("Cash on delivery")
                    .fontWeight(.medium)
                    .foregroundStyle(Color.text)
                
                Text("Pay by cach on delivery")
                    .font(.callout)
                    .foregroundStyle(Color.text)
            }
            
            
            Spacer(minLength: 80)
            
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(.green)
            
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top)
        
    }
    
    var creditCard: some View {
        
        HStack {
            
            Text("Credit Card")
                .fontWeight(.medium)
                .foregroundStyle(Color.text)
            
            Text("( Comming soon )")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(Color.gray)
            
            Spacer()
            
        }
        .padding(20)
        .background(Color.init(uiColor: .systemGray4))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top)
        
        
    }
    
    
    var continueButton: some View {
        
        NavigationLink {
            OrderConfirmationView(rootIsActive: $rootIsActive)
        } label: {
            Text("CONTINUE")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(Color.text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .padding()
        
    }
    
}
