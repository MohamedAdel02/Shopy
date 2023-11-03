//
//  DeliveryAddressViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 02/11/2023.
//

import Foundation
import MapKit

enum AddressSource {
    case profile
    case map
}

class DeliveryAddressViewModel: ObservableObject {
    
    @Published var selectedAddress: AddressSource? = nil
    @Published var addressPickedUp: String?
    @Published var coordinate: CLLocationCoordinate2D?

    func getAddress(from coordinate: CLLocationCoordinate2D) {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.coordinate = coordinate
        
        Task {
            do {
                let placemark = try await geoCoder.reverseGeocodeLocation(location).first
                await getAddressDetails(placemark: placemark)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    @MainActor func getAddressDetails(placemark: CLPlacemark?)  {
        
        var address = ""
        
        guard let placemark = placemark else {
            return
        }
        
        if let postalCode = placemark.postalCode {
            address += "\(postalCode)\n"
        }
        
        if let name = placemark.name {
            address += "\(name)\n"
        }
        
        if let subLocality = placemark.subLocality {
            address += "\(subLocality)\n"
        }

        if let locality = placemark.locality {
            address += "\(locality), "
        }
        
        if let city = placemark.administrativeArea {
            address += "\(city), "
        }
        
        if let country = placemark.country {
            address += "\(country)"
        }
        
        if address.isEmpty {
            return
        }
        
        addressPickedUp = address

    }
    
}
