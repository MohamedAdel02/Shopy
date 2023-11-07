//
//  OrderViewModel.swift
//  Shopy
//
//  Created by Mohamed Adel on 06/11/2023.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var orders = [Order]()
    @Published var order: Order?
    @Published var detailsIsPresented = false

    init() {
        
        getOrders()
    }
    
    func getOrders() {

        Task {
            do {
                guard let orders = try await FirestoreManager.shared.getOrders() else {
                    return
                }
                await MainActor.run {
                    self.orders = orders
                    print(orders)
                }
            } catch {
                print("getOrders \(error.localizedDescription)")
            }
        }
    }
    
    
    func addOrder(cartProducts: [CartProduct], price: Double, address: String) {
        
        let id = UUID().uuidString
        let date = getDate()
        
        order = Order(id: id, products: cartProducts, price: price, address: address, orderedOn: date)

        if let order = order {
            orders.append(order)
            storeOrder(order: order)
        }
        
        detailsIsPresented = true
    }
    
    private func getDate() -> String? {

        let date = Date().description(with: .current)
        if let lower = date.firstIndex(of: " "),
           let upper = date.range(of: "at")?.lowerBound {
            return date[lower..<upper].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return nil
    }
    
    func storeOrder(order: Order) {
        
        Task {
            do {
                try await FirestoreManager.shared.updateOrders(order: order)
            } catch {
                print("storeOrder \(error.localizedDescription)")
            }
        }
    }
    
}
