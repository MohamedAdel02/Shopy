//
//  OrdersListView.swift
//  Shopy
//
//  Created by Mohamed Adel on 07/11/2023.
//

import SwiftUI

struct OrdersListView: View {
    
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    var body: some View {
        VStack {
            List(orderViewModel.orders) { order in
                NavigationLink {
                    OrderDetailsView(rootIsActive: .constant(false), order: order, source: .list)
                } label: {
                    OrderCell(order: order)
                }

            }
            .listStyle(.grouped)
  
        }
    }
}

#Preview {
    OrdersListView()
}
