//
//  ProfileInfoViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 01/11/2023.
//

import Foundation
import PhotosUI
import SwiftUI
import Combine

class ProfileInfoViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var email = ""
    @Published var countries = [String]()
    @Published var country = "Egypt"
    @Published var city = ""
    @Published var address = ""
    @Published var selectedImage: PhotosPickerItem?
    @Published var alertIsPresented = false
    var alertTitle = ""
    
    
    init() {
        
        countries = Countries.getCountries()
    }
    
    
    func setUserData(user: User?) {
        
        guard let user = user else {
            return
        }
        
        name = user.name ?? ""
        email = user.email ?? ""
        country = user.country ?? "Egypt"
        city = user.city ?? ""
        address = user.address ?? ""
                
    }
    
    
    func getUserData() -> User {
        
        return User(name: name, email: email, country: country, city: city, address: address)
    }

    
    func getImageData(from pickerItem: PhotosPickerItem?) async -> Data? {
        
        guard let pickerItem = pickerItem else {
            return nil
        }

        let data = try? await pickerItem.loadTransferable(type: Data.self)
        
        guard let data = data else {
            return nil
        }
        
        return await checkDataSize(data: data)
 
    }
    
    func checkDataSize(data: Data) async -> Data? {
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        let string = bcf.string(fromByteCount: Int64(data.count))
        let fileSize = string.components(separatedBy: " ").first ?? "0.0"
        let size = Double(fileSize) ?? 0.0
        
        if size > 8 {
            await MainActor.run {
                alertTitle = "Image size exceeds the maximum size, please choose another image"
                alertIsPresented = true
            }
            return nil
        } else {
            return data
        }
        
    }

    
}
