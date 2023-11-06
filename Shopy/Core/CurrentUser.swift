//
//  CurrentUser.swift
//  Shopy
//
//  Created by Mohamed Adel on 31/10/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class CurrentUser: ObservableObject {
    
    @Published var isLogin = false
    @Published var user: User?
    @Published var userPhoto: Data?
    
    var subscribers = Set<AnyCancellable>()
    
    init() {
        
        if Auth.auth().currentUser != nil {
            isLogin = true
        }
        
        isLoginChanged()
    }
    
    
    func isLoginChanged() {
        
        $isLogin
            .sink { [weak self] isLogin in
                if isLogin {
                    self?.getUserData()
                    self?.getImage()
                } else {
                    self?.user = nil
                }
            }
            .store(in: &subscribers)
        
    }
    
    
    func getUserData() {
        
        Task {
            do {
                let user = try await FirestoreManager.shared.getUserInfo()
                await MainActor.run {
                    self.user = user
                }
            } catch {
                print("getUserData \(error.localizedDescription)")
            }
        }
    }
    
    func updateUserData(user: User) {
        
        Task {
            
            do {
                try await FirestoreManager.shared.updateUerInfo(user: user)
                getUserData()
            } catch {
                print("updateUserData \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func updateUserAddress(address: String) {
        
        Task {
            do {
                try await FirestoreManager.shared.updateUserAddress(address: address)
            } catch {
                print("updateUserAddress \(error.localizedDescription)")
            }
        }
        
    }
    
    func updateImage(image: Data) {
        
        Task {
             
            do {
                try await StorageManager.shared.uploadImage(data: image)
            } catch {
                print("updateImage \(error.localizedDescription)")
            }
               
        }
        
    }
    
    func getImage() {
        
        Task {
            do {
                let image = try await StorageManager.shared.getImage()
                await MainActor.run {
                    userPhoto = image
                }
            } catch {
                print("getImage \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteImage() {
        
        Task {
            do {
                try await StorageManager.shared.deleteImage()
            } catch {
                print("deleteImage \(error.localizedDescription)")
            }
        }
        
    }
    
    

}
