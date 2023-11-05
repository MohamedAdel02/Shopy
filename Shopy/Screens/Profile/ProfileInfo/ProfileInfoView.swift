//
//  ProfileInfoView.swift
//  Shopy
//
//  Created by Mohamed Adel on 01/11/2023.
//

import SwiftUI
import PhotosUI

struct ProfileInfoView: View {

    @StateObject var profileInfoViewModel = ProfileInfoViewModel()
    @EnvironmentObject var currentUser: CurrentUser
    @Environment(\.dismiss) var dismiss
    @State private var removeImageConfirmation = false
    @State private var didAppear = false
    @State private var shouldDismiss = false
    
    var body: some View {
            ScrollView {
                
                VStack(spacing: 25) {
                    
                    imageView
                    ProfileInfoTextField(label: "Email", text: $profileInfoViewModel.email, isDisabled: true)
                    ProfileInfoTextField(label: "Name", text: $profileInfoViewModel.name)
                    countryPicker
                    ProfileInfoTextField(label: "City", text: $profileInfoViewModel.city)
                    addressField
                    saveButton
                    
                }
                .padding(.vertical, 50)
                
            }
            .onAppear {
                if !didAppear {
                    profileInfoViewModel.setUserData(user: currentUser.user)
                    didAppear = true
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .alert(profileInfoViewModel.alertTitle, isPresented: $profileInfoViewModel.alertIsPresented) {
                Button("OK", role: .cancel) {
                    if shouldDismiss {
                        dismiss()
                    }
                }
            }
            .confirmationDialog("Are you sure you want to remove the profile image?", isPresented: $removeImageConfirmation, titleVisibility: .visible, actions: {
                Button("Yes") {
                    currentUser.userPhoto = nil
                    currentUser.deleteImage()
                }
            })
            .onChange(of: profileInfoViewModel.selectedImage, { _, newValue in
                Task {
                    let data = await profileInfoViewModel.getImageData(from: newValue)
                    if let data = data {
                        currentUser.userPhoto = data
                        currentUser.updateImage(image: data)
                    }
                }
            })
            .background(Color.init(uiColor: .systemGray5))
            .scrollIndicators(.hidden)
            .toolbarBackground(Color.init(uiColor: .systemGray5))
            .toolbarBackground(.visible, for: .navigationBar)
        
    }
}

#Preview {
    ProfileInfoView()
}

extension ProfileInfoView {
    
    var imageView: some View {
        
        
        VStack() {
            
            
            if let data = currentUser.userPhoto, let image = UIImage(data: data) {
                
                ZStack(alignment: .topTrailing) {
                    
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.text)
                        .background(Color.init(uiColor: .systemGray4))
                        .clipShape(.circle)
                    
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .foregroundStyle(.red)
                        .background(Color.init(uiColor: .systemGray4))
                        .clipShape(.circle)
                        .offset(x: 15)
                        .onTapGesture {
                            removeImageConfirmation = true
                        }
                }
            } else {
                
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding(20)
                    .foregroundStyle(Color.text)
                    .background(Color.init(uiColor: .systemGray4))
                    .clipShape(.circle)
            }

            PhotosPicker(selection: $profileInfoViewModel.selectedImage, matching: .images) {
                Text("Change photo")
                    .foregroundStyle(Color.text)
            }

        }
    }
    
    var countryPicker: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Country")
                .padding(.leading, 8)
                .fontWeight(.medium)
                .foregroundStyle(Color.text)
            
            
            Picker("Country", selection: $profileInfoViewModel.country) {
                
                ForEach(profileInfoViewModel.countries, id: \.self) { country in
                    Text(country)
                }
            }
            .pickerStyle(.navigationLink)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal)
 
    }
    
    var addressField: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text("Address")
                .padding(.leading, 8)
                .fontWeight(.medium)
                .foregroundStyle(Color.text)
            
            TextEditor(text: $profileInfoViewModel.address)
                .frame(height: 100)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))

        }
        .padding(.horizontal)
        
    }
    
    var saveButton: some View {
        
        Button(action: {
            let user = profileInfoViewModel.getUserData()
            currentUser.updateUserData(user: user)
            profileInfoViewModel.alertTitle = "Your profile information has been updated successfully"
            profileInfoViewModel.alertIsPresented = true
            shouldDismiss = true
        }, label: {
            Text("Save")
                .font(.headline)
                .frame(width: 100, height: 10)
                .padding()
                .foregroundStyle(Color(UIColor.systemGray6))
                .background(Color.text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
        .padding(.top)
    }
    
}

struct ProfileInfoTextField: View {
    
    var label: String
    @Binding var text: String
    var isDisabled = false
    
    var body: some View {

        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .padding(.leading, 8)
                .fontWeight(.medium)
                .foregroundStyle(Color.text)
            
            TextField(label, text: $text)
                .padding()
                .background(isDisabled ? Color.init(uiColor: .systemGray4) : .white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .disabled(isDisabled)
        }
        .padding(.horizontal)
        
    }
    
}
