//
//  TextFieldView.swift
//  Shopy
//
//  Created by Mohamed Adel on 22/10/2023.
//

import SwiftUI

struct TextFieldView: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    var isSecured = false
    
    var body: some View {
        VStack(spacing: 3) {
            
            Text(label)
                .padding(.leading, 10)
                .fontWeight(.medium)
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Group {
                if isSecured {
                    SecureField(placeholder, text: $text)
                    
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .frame(maxWidth: .infinity, maxHeight: 35)
            .padding(.horizontal)
            .background(Color("backgroundColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        
    }
}

#Preview {
    TextFieldView(label: "Test",placeholder: "Test", text: .constant(""))
}
