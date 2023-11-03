//
//  DeleteAccountView.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import SwiftUI

struct DeleteAccountView: View {
    
    @StateObject var deleteAccountViewModel = DeleteAccountViewModel()
    @State var confirmationIsPresented = false
    @EnvironmentObject var currentUser: CurrentUser

    
    var body: some View {
        ZStack {
            
            Color.init(uiColor: .systemGray5)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Deleting your account is a permanent operation")
                    .foregroundStyle(Color("textColor"))
                    .font(.callout)
                
                TextFieldView(label: "Password", placeholder: "Enter your Password", text: $deleteAccountViewModel.password, isSecured: true)
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        confirmationIsPresented = true
                    }, label: {
                        Text("Delete")
                            .font(.headline)
                            .frame(width: 100, height: 10)
                            .padding()
                            .foregroundStyle(Color(UIColor.systemGray6))
                            .background(Color("textColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    })
                }
                .padding(.top)
                
                Spacer()
            }
            .navigationTitle("Delete Account")
            .padding(.top, 40)
            .padding(.horizontal)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .confirmationDialog("Are you sure you want to delete your account?", isPresented: $confirmationIsPresented, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                deleteAccountViewModel.deletePressed()
            }
        }
        .alert(deleteAccountViewModel.alertTitle, isPresented: $deleteAccountViewModel.alertIsPresented, actions: {
            Button("OK", role: .cancel) { }
        }) {
            Text(deleteAccountViewModel.alertMessage)
        }
        .onChange(of: deleteAccountViewModel.isDeleted) { _, _ in
            currentUser.isLogin = false
        }
        
    }
}

#Preview {
    DeleteAccountView()
}