//
//  SignUpView.swift
//  Shopy
//
//  Created by Mohamed Adel on 21/10/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var signUpViewModel: SignUpViewModel
    @Binding var isHavingAccount: Bool
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(Color(UIColor.systemGray4))
                    .ignoresSafeArea()
                
                VStack {
                    
                    signUpInfo
                    signUpButton
                    goToSignUp
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: 550)
               
        }
        .alert(signUpViewModel.alertTitle, isPresented: $signUpViewModel.alertIsPresented) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(signUpViewModel.alertMessage)
        }
    }
    
    
}

#Preview {
    SignUpView(signUpViewModel: SignUpViewModel(), isHavingAccount: .constant(false))
}


extension SignUpView {
    
    
    var signUpInfo: some View {
        
        VStack(spacing: 20) {
            
            TextFieldView(label: "Name", placeholder: "First and last name", text: $signUpViewModel.name)
            TextFieldView(label: "Email", placeholder: "Enter your email", text: $signUpViewModel.email)
                .keyboardType(.emailAddress)
            TextFieldView(label: "Password", placeholder: "At least 6 characters", text: $signUpViewModel.password, isSecured: true)
            
            countryPicker
            
        }
        .padding(.top, 10)
        
    }
    
    
    var countryPicker: some View {
        
        VStack(spacing: 3) {
            
            Text("Country")
                .padding(.leading, 10)
                .fontWeight(.medium)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Picker("Country", selection: $signUpViewModel.selectedCountry) {
                
                ForEach(signUpViewModel.countries, id: \.self) { country in
                    Text(country)
                }
            }
            .pickerStyle(.navigationLink)
            .padding()
            .frame(height: 35)
            .tint(.init(uiColor: UIColor.systemGray3))
            .background(Color("backgroundColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        
    }
    
    var signUpButton: some View {
        
        HStack {
            
            Spacer()
            
            Button(action: {
                hideKeyboard()
                signUpViewModel.signUpPressed()
            }, label: {
                Text("Sign up")
                    .font(.headline)
                    .frame(width: 100, height: 10)
                    .padding()
                    .foregroundStyle(Color(UIColor.systemGray6))
                    .background(Color("textColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            })
            
        }
        .padding(.top, 25)
        
    }
    
    var goToSignUp: some View {
        
        HStack(alignment: .center) {
            
            Text("Have an account already?")
                .font(.callout)
                .foregroundStyle(Color.gray)
            
            Button {
                withAnimation {
                    isHavingAccount = true
                }
            } label: {
                Text("Log in")
                    .foregroundStyle(Color("textColor"))
            }
            
        }
        .padding(.top, 20)
        
    }
}
