//
//  ProfileView.swift
//  Shopy
//
//  Created by Mohamed Adel on 17/10/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var currentUser: CurrentUser
    @State var logoutConfirmation = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                profileTopView
                profileOptions
                Spacer()
                logoutButton
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundStyle(Color(red: 0.522, green: 0.740, blue: 0.776))
            }
            .background(Color.init(uiColor: .systemGray5))
            .navigationDestination(for: ProfileOption.self, destination: { option in
                switch option {
                case .info:
                    ProfileInfoView()
                case .orders:
                    ChangePasswordView()
                case .changePassword:
                    ChangePasswordView()
                case .deleteAccount:
                    DeleteAccountView()
                }
            })
            .confirmationDialog("Are you sure you want to log out?", isPresented: $logoutConfirmation, titleVisibility: .visible, actions: {
                Button("Yes") {
                    profileViewModel.logout()
                }
            })
            .onChange(of: profileViewModel.isLogout) { _, _ in
                withAnimation {
                    currentUser.isLogin = false
                }
            }
        }
        .tint(Color("textColor"))

    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
    
    var profileTopView: some View {
        
        HStack {
            
            if let name = currentUser.user?.name {
                
                Text("Hello, \(name.components(separatedBy: " ").first ?? "")")
                    .foregroundStyle(Color("textColor"))
                    .font(.custom("Courgette-Regular", size: 25))
                
            }
            
            Spacer()
            
            
            if let data = currentUser.userPhoto, let image = UIImage(data: data) {
                
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundStyle(Color("textColor"))
                    .background(Color.init(uiColor: .systemGray4))
                    .clipShape(.circle)
            } else {
                
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(20)
                    .foregroundStyle(Color("textColor"))
                    .background(Color.init(uiColor: .systemGray4))
                    .clipShape(.circle)
            }
            
            
        }
        .padding(30)
        
    }
    
    var profileOptions: some View {
        
        VStack(spacing: 15) {
            ForEach(profileViewModel.profileOptions, id: \.self) { option in
               
                NavigationLink(value: option) {
                    
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
        
    }
    
    
    var logoutButton: some View {
        
        Button(action: {
            logoutConfirmation = true
        }, label: {
            Text("Log out")
                .foregroundStyle(.white)
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(Color("textColor"))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
        })
        
    }
     
}
