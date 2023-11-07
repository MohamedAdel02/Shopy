//
//  OrderCell.swift
//  Shopy
//
//  Created by Mohamed Adel on 07/11/2023.
//

import SwiftUI

struct OrderCell: View {
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            orderNumber
            orderProducts
            orderTotal
            orderDate
        }
    }
}

#Preview {
    OrderCell(order: MockData.order)
}

extension OrderCell {
    
    var orderNumber: some View {
        VStack(alignment: .leading) {
            Text("Order #:")
                .font(.title3)
                .fontWeight(.medium)
            Text(order.id)
                .font(.system(size: 15))
        }
        .foregroundStyle(Color.text)
        .padding(.bottom, 5)
    }
    
    var orderProducts: some View {
        VStack {
            ForEach(order.products) { product in
                HStack {
                    Text(product.title)
                        .lineLimit(1)
                    Spacer()
                    Text("x \(product.quantity)")
                        .fontWeight(.medium)
                }
            }
        }
        .padding()
    }
    
    var orderTotal: some View {
        HStack {
            Text("Order total:")
                .foregroundStyle(Color.gray)
            Text(order.price, format: .currency(code: "USD"))
                .foregroundStyle(Color.text)
                .fontWeight(.medium)
            Spacer()
        }
        .fontWeight(.medium)
        .padding(.leading, 5)
    }
    
    var orderDate: some View {
        Group {
            if let date = order.orderedOn {
                HStack {
                    Text("Ordered on:")
                        .foregroundStyle(Color.gray)
                    Text(date)
                        .foregroundStyle(Color.text)
                        .fontWeight(.medium)
                    Spacer()
                }
                .padding(.leading, 5)
            }
        }
    }
}
