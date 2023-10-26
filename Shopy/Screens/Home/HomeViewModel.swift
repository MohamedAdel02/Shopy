//
//  HomeViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 18/10/2023.
//

import Foundation
import Combine
import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var products = [Product]()
    @Published var categories = [String]()
    @Published var isLoading = true
    @Published var searchText = ""
    @Published var productSearchResult = [Product]()
    @Published var searchSelectedProduct: Product?
    
    var imageSliderData = [
        (imageName: "image1", id: 14),
        (imageName: "image2", id: 3),
        (imageName: "image3", id: 6),
    ]
    
    var productSubscriber: AnyCancellable?
    var categorySubscriber: AnyCancellable?
    var searchResultSubscriber: AnyCancellable?
    
    init() {
        
        getAllProducts()
        getCategories()
        getSearchResultProduct()
    }
    
    func getAllProducts() {
        
        guard let url = URL(string: K.API.allProducts) else {
            print("Invalid URL")
            return
        }
        
        productSubscriber = NetworkManager.shared.data(url: url)
            .sink { completion in
                NetworkManager.shared.handleCompletion(completion: completion)
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.productSubscriber?.cancel()
            }
    }
    
    
    func getCategories() {
        
        guard let url = URL(string: K.API.categories) else {
            print("Invalid URL")
            return
        }
        
        categorySubscriber = NetworkManager.shared.data(url: url)
            .sink { completion in
                NetworkManager.shared.handleCompletion(completion: completion)
            } receiveValue: { [weak self] categories in
                self?.categories = categories
                self?.categories.sort(by: >)
                self?.isLoading = false
                self?.categorySubscriber?.cancel()
            }
    }
    
    
    func getSearchResultProduct() {
        
        searchResultSubscriber = $searchText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.productSearchResult = self?.products.filter({ $0.title.localizedCaseInsensitiveContains(text) }) ?? []
            }
    }
    
}
