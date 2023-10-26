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
    @Published var availableSizes = [Size]()
    @Published var selectedSize: Size?
    @Published var sizeIsAvailable = false
    var allSizes: [Size] = [.small, .medium, .large, .xLarge, .xxLarge]
    
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
                self?.getAvailableSizes(id: product?.id)
                self?.similarproductsSubject.send(product?.category ?? "")
                self?.productSubscriber?.cancel()
            }
    }
    
    func getAvailableSizes(id: Int?) {
        
        for size in SizeMockData.availabeSizes {
            if size.id == id {
                sizeIsAvailable = true
                availableSizes = size.availableSizes
                selectedSize = availableSizes[0]
            }
        }
    }
    
    func addSimilarProductsSubscriber() {
        
        similarproductsSubscriber = similarproductsSubject.sink { [weak self] category in
            guard let url = URL(string: "\(K.API.categoryProducts)\(category)") else {
                print("Invalid URL")
                return
            }
            
            self?.getSimilarProducts(url: url)
            self?.similarproductsSubscriber?.cancel()
        }

    }
    
    
    func getSimilarProducts(url: URL) {
        
        NetworkManager.shared.data(url: url)
            .sink { completion in
                NetworkManager.shared.handleCompletion(completion: completion)
            } receiveValue: { [weak self] similarProducts in
                self?.similarProducts = similarProducts
                self?.similarProducts = similarProducts.filter { $0.id != self?.product?.id }
            }
            .store(in: &subscribers)
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
