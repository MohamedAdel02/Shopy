//
//  ProductDetailsView.swift
//  Shopy
//
//  Created by Mohamed Adel on 25/10/2023.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @StateObject var productDetailsViewModel = ProductDetailsViewModel()
    var productID: Int
    
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var popToRoot: PopToRoot
    @Environment(\.dismiss) private var dismiss
    @State private var alertIsPresented = false
    @State private var alertTitle = ""
    
    var body: some View {

        VStack {
            if productDetailsViewModel.isLoading {
                ProgressView()
                
            } else {

                GeometryReader { geo in
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            productTitle
                            ProductImage(width: geo.size.width, imageURL: productDetailsViewModel.product?.image ?? "")
                            
                            productPrice
                            
                            if productDetailsViewModel.sizeIsAvailable {
                                productSize
                            }
                            
                            productQuantity
                            moreAboutTheProduct
                            similarProducts
                        }
                    }
                    .background(Color.background)
                    .scrollIndicators(.hidden)
                }
                
                HStack(alignment: .bottom) {
                    productTotalPrice
                    Spacer()
                    addToCartButton
                }
                
                Line()
            }
        }
        .onAppear {
            productDetailsViewModel.getProduct(id: productID)
        }
        .onChange(of: popToRoot.navToHome) {
            dismiss()
        }
        .alert(alertTitle, isPresented: $alertIsPresented) {
            Button("OK") { }
        }

    }
}

#Preview {
    ProductDetailsView(productID: MockData.product.id)
}


extension ProductDetailsView {
    
    var productTitle: some View {
        Text(productDetailsViewModel.product?.title ?? "")
            .padding(20)
            .font(.title2)
            .foregroundStyle(Color.text)
            .fontWeight(.semibold)
            .fixedSize(horizontal: false, vertical: true)
        
    }
    
    
    var productPrice: some View {
        
        VStack(alignment: .leading) {
            Text(productDetailsViewModel.product?.price ?? 0, format: .currency(code: "USD"))
                .padding(.top)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.text)
            
            Text("All prices include VAT.")
                .foregroundStyle(Color.text)
            
            Text("Free delivery")
                .foregroundStyle(Color.turquoise)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)

    }
    
    var productSize: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text("Size")
                .foregroundStyle(Color("textColor"))
                .fontWeight(.semibold)
            
            HStack {
                
                ForEach(productDetailsViewModel.allSizes, id: \.self) { size in
                    
                    if productDetailsViewModel.availableSizes.contains(size) {
                        Text(size.rawValue)
                            .frame(width: 40, height: 40)
                            .background(productDetailsViewModel.selectedSize == size ? Color.turquoise : Color.init(uiColor: UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onTapGesture {
                                productDetailsViewModel.selectedSize = size
                            }
                    } else {
                        Text(size.rawValue)
                            .frame(width: 40, height: 40)
                            .background(Color.init(uiColor: UIColor.systemGray2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                Rectangle()
                                    .frame(width: 2, height: 48)
                                    .rotationEffect(Angle(degrees: -45))
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 30)
        
    }
    
    
    var productQuantity: some View {
        
            VStack(alignment: .leading, spacing: 0) {
                
                if !productDetailsViewModel.sizeIsAvailable {
                    Text("In Stock")
                        .font(.title2)
                        .foregroundStyle(Color.green)
                        .fontWeight(.semibold)
                }
            
            
            HStack(spacing: 15) {
                
                Text("Quantity")
                    .foregroundStyle(Color.text)
                    .fontWeight(.semibold)

                
                Button {
                    productDetailsViewModel.quantityDecreased()
                } label: {
                    Text("-")
                        .frame(width: 40, height: 40)
                        .background(Color.init(uiColor: .systemGray5))
                        .foregroundStyle(Color.text)
                        .overlay(productDetailsViewModel.isMinQuantity ?  Color.init(uiColor: .systemGray3) .opacity(0.8) : Color.white.opacity(0))
                        .clipShape(Circle())
                }
                .disabled(productDetailsViewModel.isMinQuantity)
                
                Text(productDetailsViewModel.quantity, format: .number)
                    .font(.title3)
                    .foregroundStyle(Color.text)
                
                Button {
                    productDetailsViewModel.quantityIncreased()
                } label: {
                    Text("+")
                        .frame(width: 40, height: 40)
                        .background(Color.init(uiColor: .systemGray5))
                        .foregroundStyle(Color.text)
                        .overlay(productDetailsViewModel.isMaxQuantity ? Color.init(uiColor: .systemGray3) .opacity(0.6): Color.white.opacity(0))
                        .clipShape(Circle())
                }
                .disabled(productDetailsViewModel.isMaxQuantity)
                
            }
        }
        .padding(.horizontal, 20)
 
    }
    
    var moreAboutTheProduct: some View {
        
        VStack(alignment: .leading) {
            Text("More about the product:")
                .foregroundStyle(Color.text)
                .font(.title3)
                .fontWeight(.semibold)
            
            
            Text(productDetailsViewModel.product?.description ?? "")
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(Color.text)
        }
        .padding(.horizontal, 20)
        .padding(.top)
  
    }
    
    var similarProducts: some View {
        
        VStack(alignment: .leading){
            Text("You might also like")
                .foregroundStyle(Color.text)
                .padding(.horizontal, 20)
                .padding(.top, 30)
                .font(.title2)
                .fontWeight(.semibold)
            
            ProductHList(products: productDetailsViewModel.similarProducts
                .filter{ $0.id != productDetailsViewModel.product?.id ?? -1 })
        }
        
    }
    
    
    var productTotalPrice: some View {
        
        VStack(alignment: .leading) {
            Text("Total")
                .font(.title3)
                .foregroundStyle(Color.text)
                .fontWeight(.semibold)
            
            Text(productDetailsViewModel.totalPrice, format: .currency(code: "USD"))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(Color.turquoise)
        }
        .padding(.horizontal, 20)
    }
    

    var addToCartButton: some View {
        
        Button(action: {
            guard let product = productDetailsViewModel.product else {
                return
            }

            let cartProduct = CartProduct(id: product.id, title: product.title, image: product.image, price: product.price, size: productDetailsViewModel.selectedSize, quantity: productDetailsViewModel.quantity)
            
            if cartViewModel.cartProducts.contains(where: { $0.id == cartProduct.id }) {
                alertTitle = "The product is already in the cart"
                alertIsPresented.toggle()
            } else {
                cartViewModel.cartProducts.append(cartProduct)
                cartViewModel.updateCart(product: cartProduct)
            }
            
        }, label: {
            Text("ADD TO CART")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(Color.text)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
        })
        .padding(.trailing)
    }
    
    
      
}

struct ProductImage: View {
    
    var width: Double
    var imageURL: String
    
    var body: some View {
 
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, minHeight: 300)
            
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .frame(width: width - 130, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
            }
        }
  
    }
    
}
