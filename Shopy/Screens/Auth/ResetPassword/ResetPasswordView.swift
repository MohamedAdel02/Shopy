//
//  ResetPasswordView.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject var resetPasswordViewModel = ResetPasswordViewModel()
    @Binding var forgotPassword: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            backButton
            
            TextFieldView(label: "Email", placeholder: "Enter your email", text: $resetPasswordViewModel.email)
                .keyboardType(.emailAddress)
                .padding(.vertical)
            
            Text("We will send a reset password link to your email")
                .foregroundStyle(Color.text)
                .frame(height: 60)
            
            sendButton
            
            Spacer()
            
        }
        .padding(.top, 25)
        .padding(.horizontal, 30)
        .alert(resetPasswordViewModel.alertTitle, isPresented: $resetPasswordViewModel.alertIsPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(resetPasswordViewModel.alertMessage)
        }
        
    }
}

#Preview {
    ResetPasswordView(forgotPassword: .constant(true))
}

extension ResetPasswordView {
    
    var backButton: some View {
        
        Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(Color.text)
            .onTapGesture {
                withAnimation {
                    resetPasswordViewModel.email = ""
                    forgotPassword = false
                }
            }
    }
    
    
    var sendButton: some View {
        
        HStack {
            
            Spacer()
            
            Button(action: {
                resetPasswordViewModel.sendPressed()
            }, label: {
                Text("SEND")
                    .font(.headline)
                    .frame(width: 100, height: 10)
                    .padding()
                    .foregroundStyle(Color(UIColor.systemGray6))
                    .background(Color.text)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            })
        }
        .padding(.top, 20)
        
        
    }
    
}
