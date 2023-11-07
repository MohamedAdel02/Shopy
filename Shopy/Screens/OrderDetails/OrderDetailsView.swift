//
//  OrderDetailsView.swift
//  Shopy
//
//  Created by Mohamed Adel on 06/11/2023.
//

import SwiftUI

enum OrderViewSource {
    case list
    case confirmation
}

struct OrderDetailsView: View {
    
    @EnvironmentObject var popToRoot: PopToRoot
    @Binding var rootIsActive: Bool
    @State var progressViewIsActive = false
    let order: Order
    let source: OrderViewSource
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView {
                Group {
                    if progressViewIsActive {
                        ProgressView()
                    } else {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            if source == .confirmation {
                                confirmationText
                            }
                            orderNumber
                            
                            LazyVStack(spacing: 5) {
                                ForEach(order.products) { product in
                                    OrderProductCell(product: product)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                            
                            orderDate
                            orderTotal
                            orderAddress
                            Spacer()
                            if source == .confirmation {
                                continueShoppingButton
                            }
                            Line()
                        }
                        
                    }
                }
                .frame(minWidth: geo.size.width, minHeight: geo.size.height)
                .background(Color.init(uiColor: .systemGray6))
            }
            .scrollIndicators(.hidden)
            
        }
    }
}

#Preview {
    OrderDetailsView(rootIsActive: .constant(false), order: MockData.order, source: .confirmation)
}

extension OrderDetailsView {
    
    var confirmationText: some View {
        
        Text("Your order has been confirmed")
            .font(.title3)
            .foregroundStyle(Color.green)
            .bold()
            .padding(.horizontal)
            .padding(.top)
    }
    
    var orderNumber: some View {
        
        VStack(alignment: .leading) {
            Text("Order #:")
                .font(.title3)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            Text(order.id)
                .font(.callout)
                .foregroundStyle(Color.text)
        }
        .padding()
        
    }
    
    var orderDate: some View {
        Group {
            if let date = order.orderedOn {
                HStack(alignment: .top, spacing: 22) {
                    Text("Ordered on: ")
                        .padding(.leading, 20)
                        .padding(.top, 10)
                        .foregroundStyle(Color.text)
                        .fontWeight(.medium)
                    
                    Text(date)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color.text)
                        .fontWeight(.medium)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.trailing, 40)
                }
            }
        }
    }
    
    var orderTotal: some View {
        HStack(alignment: .top, spacing: 25) {
            Text("Order total: ")
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            
            Text(order.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 40)
        }
        
        
    }
    
    var orderAddress: some View {
        
        HStack(alignment: .top, spacing: 45) {
            Text("Address: ")
                .padding(.leading, 20)
                .padding(.top, 10)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            
            Text(order.address)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.trailing, 40)
        }
        
    }
    
    var continueShoppingButton: some View {
        
        HStack {
            Spacer ()
            Button(action: {
                continueShoppingPressed()
            }, label: {
                Text("Continue Shopping")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.text)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            })
            .padding(.bottom, 25)
            
            Spacer()
        }
    }
    
    
    func continueShoppingPressed() {
        
        withAnimation {
            progressViewIsActive = true
        }
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            await MainActor.run {
                rootIsActive = false
                popToRoot.selectedTab = 0
            }
        }
        
    }
}
