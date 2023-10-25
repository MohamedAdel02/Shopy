//
//  SignUpViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 22/10/2023.
//

import Foundation


@MainActor class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var selectedCountry = "Egypt"
    @Published var countries = [String]()
    @Published var alertIsPresented = false
    @Published var userSignedUp = false
    var alertTitle = ""
    var alertMessage = ""

    
    
    init() {
        
        countries = getCountries()
    }
    
    
    func getCountries() -> [String] {
        let countriesCodes = Locale.Region.isoRegions
        var countries = [String]()
        
        for countryCode in countriesCodes {
            let identifier = countryCode.identifier
            
            if identifier.count == 2 && identifier != "QO" && identifier != "AQ" {
                countries.append(Locale.current.localizedString(forRegionCode: identifier) ?? "")
            }
        }
        return countries.sorted()
    }
    
    func signUpPressed() {
        
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if fieldsAreEmpty(name: name, email: email, password: password) {
            return
        }
        
        if !isValidEmail(email: email) || !isValidPassword(password: password) {
            return
        }

        createAccount(email: email, password: password)
    }
    
    
    func fieldsAreEmpty(name:String, email: String, password: String) -> Bool{
        
        if email.isEmpty || password.isEmpty {
            alertTitle = "Empty field"
            alertMessage = "Please enter all required fields"
            
            alertIsPresented = true
            return true
        }
        return false
    }
    
    
    func isValidEmail(email: String) -> Bool {
        
        if !email.isValidEmail() {
            alertTitle = "Invalid email"
            alertMessage = "Please enter a valid email"
            
            alertIsPresented = true
            return false
        }
        return true
    }
    
    
    func isValidPassword(password: String) -> Bool {
        
        if password.count < 6 {
            alertTitle = "Invalid password"
            alertMessage = "The password must be at least 6 characters"
            
            alertIsPresented = true
            return false
        }
        return true
    }
    
    
    func createAccount(email: String, password: String) {
        
        Task {
            do {
                try await AuthManager.shared.createAccount(email: email, password: password, name: name, country: selectedCountry)
                userSignedUp = true
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
}
