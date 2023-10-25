//
//  ProductDetailsViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 25/10/2023.
//

import Foundation
import Combine


class ProductDetailsViewModel: ObservableObject {
    
    @Published var product: Product?
    @Published var quantity = 1
    @Published var totalPrice = 0.0
    @Published var similarProducts = [Product]()
    @Published var enableIncreasingQuantity = true
    @Published var enableDecreasingQuantity = false
    @Published var isLoading = true
    
    var productSubscriber: AnyCancellable?
    var similarproductsSubscriber: AnyCancellable?
    var similarproductsSubject = PassthroughSubject<String, Never>()
    var subscribers = Set<AnyCancellable>()
    
    init() {
        
        addSimilarProductsSubscriber()
        updateTotalPrice()
    }
    
    
    func getProduct(id: Int) {
        
        guard let url = URL(string: "\(K.API.allProducts)/\(id)") else {
            print("Invalid URL")
            return
        }
        
        productSubscriber = NetworkManager.shared.data(url: url)
            .sink { completion in
                NetworkManager.shared.handleCompletion(completion: completion)
            } receiveValue: { [weak self] product in
                self?.product = product
                self?.totalPrice = product?.price ?? 0.0
                self?.isLoading = false
                self?.similarproductsSubject.send(product?.category ?? "")
                self?.productSubscriber?.cancel()
            }
    }
    
    func addSimilarProductsSubscriber() {
        
        similarproductsSubject.sink { [weak self] category in
            guard let url = URL(string: "\(K.API.categoryProducts)\(category)") else {
                print("Invalid URL")
                return
            }
            
            self?.getSimilarProducts(url: url)
        }
        .store(in: &subscribers)

    }
    
    
    func getSimilarProducts(url: URL) {
        
        similarproductsSubscriber = NetworkManager.shared.data(url: url)
            .sink { completion in
                NetworkManager.shared.handleCompletion(completion: completion)
            } receiveValue: { [weak self] similarProducts in
                self?.similarProducts = similarProducts
                
                self?.similarProducts = similarProducts.filter { $0.id != self?.product?.id }
                self?.similarproductsSubscriber?.cancel()
            }
    }
    
    func updateTotalPrice() {
        
        $quantity
            .sink { [weak self] quantity in
                self?.totalPrice = (self?.product?.price ?? 0.0) * Double(quantity)
                
                self?.enableDecreasingQuantity = true
                self?.enableIncreasingQuantity = true
                
                if quantity == 1 {
                    self?.enableDecreasingQuantity = false
                }
                
                if quantity == 10 {
                    self?.enableIncreasingQuantity = false
                } 
            }
            .store(in: &subscribers)
    }
    
    
    func quantityIncreased() {
        quantity += 1
    }
    
    func quantityDecreased() {
        quantity -= 1
    }

    
}
