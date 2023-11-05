//
//  CartViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 27/10/2023.
//

import Foundation
import Combine

class CartViewModel: ObservableObject {
    
    @Published var cartProducts = [CartProduct]()
    @Published var totalPrice = 0.0
    var address = ""
            
    var subscribers = Set<AnyCancellable>()
    
    init() {
        updateTotalPrice()
    }
    
    func quantityIncreased(id: Int) {
        
        guard let index = cartProducts.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        cartProducts[index].quantity += 1
        quantityChanged(index: index)

    }
    
    func quantityDecreased(id: Int) {
        
        guard let index = cartProducts.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        cartProducts[index].quantity -= 1
        quantityChanged(index: index)
    }
    
    func quantityChanged(index: Array.Index) {
                     
        cartProducts[index].isMaxQuantity = false
        cartProducts[index].isMinQuantity = false
        
        if cartProducts[index].quantity == 1 {
            cartProducts[index].isMinQuantity = true
        } else if cartProducts[index].quantity == 10 {
            cartProducts[index].isMaxQuantity = true
        }
                
        cartProducts[index].totalPrice = cartProducts[index].price * Double(cartProducts[index].quantity)
    }
    
    func deletePressed(id: Int) {
        cartProducts.removeAll(where: { $0.id == id })
    }
    
    func updateTotalPrice() {
        
        $cartProducts
            .sink { [weak self] cartProducts in
                
                var totalPrice = 0.0
                
                for product in cartProducts {
                    totalPrice += product.totalPrice
                }
                
                self?.totalPrice = totalPrice
                                
            }
            .store(in: &subscribers)
    }

    
}
