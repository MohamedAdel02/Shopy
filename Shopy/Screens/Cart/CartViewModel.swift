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
        getCart()
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
                                   
        cartProducts[index].totalPrice = cartProducts[index].price * Double(cartProducts[index].quantity)
        updateCart(product: cartProducts[index])
    }
    
    func deletePressed(id: Int) {
        cartProducts.removeAll(where: { $0.id == id })
        deleteFromCart(id: id)
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
    
    func getCart() {
        
        
        Task {
            do {
                guard let prodcuts = try await FirestoreManager.shared.getCartProducts() else {
                    return
                }
                await MainActor.run {
                    cartProducts = prodcuts
                }
            } catch {
                print("getCart \(error.localizedDescription)")
            }
        }
        
    }
    
    func updateCart(product: CartProduct) {
        
        Task {
            do {
                try await FirestoreManager.shared.updateCartProduct(product: product)
            } catch {
                print("updateCart \(error.localizedDescription)")
            }
            
        }
    }
    
    func deleteFromCart(id: Int) {
        
        Task {
            do {
                try await FirestoreManager.shared.deleteCartProduct(id: id)
            } catch {
                print("deleteFromCart \(error.localizedDescription)")
            }
            
        }
    }

    
}
