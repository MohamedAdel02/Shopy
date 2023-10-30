//
//  ProfileView.swift
//  Shopy
//
//  Created by Mohamed Adel on 17/10/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            
            profileTopView
            profileOptions
            Spacer()
            logoutButton
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 2)
                .foregroundStyle(Color.accentColor)
        }
        .background(Color.init(uiColor: .systemGray5))
    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
    
    var profileTopView: some View {
        
        HStack {
            
            Text("Hello, Mohamed")
                .foregroundStyle(Color("textColor"))
                .font(.custom("Courgette-Regular", size: 25))

            Spacer()

            Image(systemName: "person")
                .resizable()
                .frame(width: 35, height: 35)
                .padding(15)
                .foregroundStyle(Color("textColor"))
                .background(Color.init(uiColor: .systemGray4))
                .clipShape(.circle)
            
        }
        .padding(30)
        
    }
    
    var profileOptions: some View {
        
        VStack(spacing: 15) {
            ForEach(profileViewModel.profileOptions, id: \.self) { option in
                
                HStack {
                    Text(option.rawValue)
                        .foregroundStyle(option == .deleteAccount ? .white : Color("textColor"))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(option == .deleteAccount ? .white : Color("textColor"))
                    
                }
                .padding()
                .background(option == .deleteAccount ? .red : .white)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding(.horizontal)
                
            }
        }
        
    }
    
    
    var logoutButton: some View {
        
        Text("Log out")
            .foregroundStyle(.white)
            .font(.title3)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(Color("textColor"))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
        
    }
     
}
