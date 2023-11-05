//
//  MapView.swift
//  Shopy
//
//  Created by Mohamed Adel on 03/11/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var deliveryAddressViewModel: DeliveryAddressViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var center = CLLocationCoordinate2D(latitude: 30.047, longitude: 31.22367)
    
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.047, longitude: 31.22367), latitudinalMeters: 10000, longitudinalMeters: 10000))
    
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                
                Map(position: $cameraPosition)
                    .onMapCameraChange { mapCameraUpdateContext in
                        center = mapCameraUpdateContext.camera.centerCoordinate
                    }
                
                Image(systemName: "mappin")
                    .resizable()
                    .frame(width: 15, height: 35)
                    .foregroundStyle(.red)
                
            }
            
            Button(action: {
                deliveryAddressViewModel.getAddress(from: center)
                dismiss()
            }, label: {
                Text("Pick")
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .font(.title3)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.text)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                
            })
            
        }
        .onAppear {
            if let coordinate = deliveryAddressViewModel.coordinate {
                cameraPosition = .region(MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000))
            }
        }
        
    }
}

#Preview {
    MapView(deliveryAddressViewModel: DeliveryAddressViewModel())
}
