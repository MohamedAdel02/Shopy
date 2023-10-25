//
//  LoginView.swift
//  Shopy
//
//  Created by Mohamed Adel on 16/10/2023.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    @Binding var isHavingAccount: Bool
    
    var body: some View {
        
        VStack {
            
            loginViewImage
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(Color(UIColor.systemGray4))
                    .ignoresSafeArea()
                
                VStack() {
                    
                    loginInfo
                    
                    HStack {
                        forgotYourPasswordButton
                        Spacer()
                        loginButton
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    
                    goToSignUp
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            
        }
        .alert(loginViewModel.alertTitle, isPresented: $loginViewModel.alertIsPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(loginViewModel.alertMessage)
        }
        
    }
    
    
}

#Preview {
    LoginView(loginViewModel: LoginViewModel(), isHavingAccount: .constant(true))
}


extension LoginView {
    
    var loginViewImage: some View {
        
        //    https://lovepik.com/image-450074735/mobile-shopping-app-icon-e-commerce-concept-vector.html Shopping Png vectors by Lovepik.com
        
        Image("loginViewImage")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: 200)
    }
    
    
    var loginInfo: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            TextFieldView(label: "Email", placeholder: "Enter your email", text: $loginViewModel.email)
                .keyboardType(.emailAddress)
            TextFieldView(label: "Password", placeholder: "Enter your password", text: $loginViewModel.password, isSecured: true)
            
        }
        .padding(.top, 10)
        
    }
    
    
    var forgotYourPasswordButton: some View {
        
        Button(action: {
            
        }, label: {
            Text("Forgot your password?")
                .font(.footnote)
                .padding(.leading, 20)
                .foregroundStyle(Color.gray)
        })
    }
    
    
    var loginButton: some View {
        
        Button(action: {
            loginViewModel.loginPressed()
        }, label: {
            Text("Login")
                .font(.headline)
                .frame(width: 100, height: 10)
                .padding()
                .foregroundStyle(Color(UIColor.systemGray6))
                .background(Color("textColor"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
        
    }
    
    
    
    var goToSignUp: some View {
        
        HStack(alignment: .center) {
            
            Text("Don't have an account?")
                .font(.callout)
                .foregroundStyle(Color.gray)
            
            Button {
                withAnimation {
                    isHavingAccount = false
                }
            } label: {
                Text("Sign up")
                    .foregroundStyle(Color("textColor"))
            }
            
        }
        .padding(.top, 15)
        
    }
    
}


