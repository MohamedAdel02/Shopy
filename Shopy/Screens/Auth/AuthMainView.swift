//
//  AuthMainView.swift
//  Shopy
//
//  Created by Mohamed Adel on 21/10/2023.
//

import SwiftUI

struct AuthMainView: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var signUpViewModel = SignUpViewModel()
    @State var isHavingAccount = true
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                appName
                
                if isHavingAccount {
                    LoginView(loginViewModel: loginViewModel, isHavingAccount: $isHavingAccount)
                } else {
                    SignUpView(signUpViewModel: signUpViewModel, isHavingAccount: $isHavingAccount)
                        .transition(.move(edge: .bottom))
                }
            }
            .background(Color("backgroundColor"))
        }
        .tint(Color("textColor"))
        .fullScreenCover(isPresented: $loginViewModel.userLogged) {
            ShopyTabView()
        }
        .fullScreenCover(isPresented: $signUpViewModel.userSignedUp) {
            ShopyTabView()
        }
        
    }
}

#Preview {
    AuthMainView()
}


extension AuthMainView {
    
    var appName: some View {
        
        VStack(alignment: .leading) {
            
            Text("SHOPY")
                .font(.custom("CinzelDecorative-Bold", size: 50))
                .foregroundStyle(Color("textColor"))
            
            Text("Whatever you want\nWhenever you need")
                .font(.custom("Courgette-Regular", size: 18))
                .foregroundStyle(Color("textColor"))
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 30)
        .padding(.top, 10)
        
    }
    
}
