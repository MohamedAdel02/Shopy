//
//  EditAddressView.swift
//  Shopy
//
//  Created by Mohamed Adel on 02/11/2023.
//

import SwiftUI

struct EditAddressView: View {
    
    @EnvironmentObject var currentUser: CurrentUser
    @Environment(\.dismiss) private var dismiss
    @State var address = ""
    
    var body: some View {
        
        ZStack {
            Color.init(uiColor: .systemGray6)
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment: .trailing) {
                    
                    addressField
                    saveButton
                }
                .padding()
                
                Spacer()
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color(red: 0.522, green: 0.740, blue: 0.776))
            }
            
        }
        .onAppear {
            if let address = currentUser.user?.address {
                self.address = address
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }
}

#Preview {
    EditAddressView()
}

extension EditAddressView {
    
    var addressField: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Address")
                .padding(.leading, 8)
                .fontWeight(.medium)
                .foregroundStyle(Color("textColor"))
            
            TextEditor(text: $address)
                .frame(height: 150)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
    }
    
    var saveButton: some View {
        
        Button(action: {
            currentUser.updateUserAddress(address: address)
            currentUser.user?.address = address
            dismiss()
        }, label: {
            Text("Save")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
        .padding()
        .disabled(address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        
    }
    
}
