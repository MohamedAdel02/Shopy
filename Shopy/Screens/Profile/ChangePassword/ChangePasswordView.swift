//
//  ChangePasswordView.swift
//  Shopy
//
//  Created by Mohamed Adel on 30/10/2023.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @StateObject var changePasswordViewModel = ChangePasswordViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            
            Color.init(uiColor: .systemGray5)
                .ignoresSafeArea()

            VStack(alignment: .trailing, spacing: 20) {
                
                TextFieldView(label: "Current password", placeholder: "", text: $changePasswordViewModel.currentPassword, isSecured: true)
                
                TextFieldView(label: "New password", placeholder: "At least 6 characters", text: $changePasswordViewModel.newPassword, isSecured: true)
                
                
                Button(action: {
                    changePasswordViewModel.changePressed()
                }, label: {
                    Text("Change")
                        .font(.headline)
                        .frame(width: 100, height: 10)
                        .padding()
                        .foregroundStyle(Color(UIColor.systemGray6))
                        .background(Color.text)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                })
                .padding(.top)
                
                Spacer()
                
            }
            .navigationTitle("Change Password")
            .padding(.top, 40)
            .padding(.horizontal)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert(changePasswordViewModel.alertTitle, isPresented: $changePasswordViewModel.alertIsPresented, actions: {
            Button("OK", role: .cancel) {
                if changePasswordViewModel.alertMessage == "" {
                    dismiss()
                }
            }
        }) {
            Text(changePasswordViewModel.alertMessage)
        }
        
    }
}

#Preview {
    ChangePasswordView()
}
