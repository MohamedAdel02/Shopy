//
//  DeliveryAddressView.swift
//  Shopy
//
//  Created by Mohamed Adel on 02/11/2023.
//

import SwiftUI

struct DeliveryAddressView: View {
    
    @StateObject var deliveryAddressViewModel = DeliveryAddressViewModel()
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        
        VStack(alignment: .trailing) {
            
            profileAddress
            pickedAddress
            continueButton
            
            Spacer()
            
            Line()
            
        }
        .background(Color.init(uiColor: .systemGray6))
        
    }
}

#Preview {
    DeliveryAddressView()
}

extension DeliveryAddressView {
    
    var profileAddress: some View {
        
        Group {
            if let address = currentUser.user?.address?.trimmingCharacters(in: .whitespacesAndNewlines),
               address.isEmpty == false {
                AddressView(deliveryAddressViewModel: deliveryAddressViewModel, address: address, addressSource: .profile)
            } else {
                
                NavigationLink {
                    EditAddressView()
                } label: {
                    NoAddressView(text: "Add your address")
                }
                
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top)
        
    }
    
    var pickedAddress: some View {
        
        Group {
            if let address = deliveryAddressViewModel.addressPickedUp {
                AddressView(deliveryAddressViewModel: deliveryAddressViewModel, address: address, addressSource: .map)
            }  else {
                NavigationLink {
                    MapView(deliveryAddressViewModel: deliveryAddressViewModel)
                } label: {
                    NoAddressView(text: "Pick-up an address location")
                }
            }
        }
        .padding(20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.top)
        
    }
    
    var continueButton: some View {
        
        Button(action: {
            
        }, label: {
            Text("CONTINUE")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 25)
                .padding(.vertical, 10)
                .background(deliveryAddressViewModel.selectedAddress == nil ? .gray : .text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        })
        .padding()
        .disabled(deliveryAddressViewModel.selectedAddress == nil ? true : false)
    }
    
}

struct NoAddressView: View {
    
    let text: String
    
    var body: some View {
        
        HStack {
            Text(text)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
        
    }
    
}


struct AddressView: View {
    
    @ObservedObject var deliveryAddressViewModel: DeliveryAddressViewModel
    let address: String
    let addressSource: AddressSource
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                VStack(alignment: .leading) {
                    Text(address)
                }
                .fontWeight(.medium)
                .foregroundStyle(Color.text)
                
                Spacer(minLength: 80)
                
                if deliveryAddressViewModel.selectedAddress == addressSource {
                    
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.green)
                } else {
                    
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color.text)
                        .frame(width: 25)
                        .onTapGesture {
                            deliveryAddressViewModel.selectedAddress = addressSource
                        }
                }
                
            }
            
            HStack {
                
                Spacer()
                NavigationLink {
                    if addressSource == .profile {
                        EditAddressView()
                    } else {
                        MapView(deliveryAddressViewModel: deliveryAddressViewModel)
                    }
                } label: {
                    Text("Edit address")
                        .foregroundStyle(Color.turquoise)
                }

            }
            .padding(.top)
        }
        
    }
    
}


