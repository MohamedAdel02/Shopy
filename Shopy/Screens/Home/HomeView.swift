//
//  HomeView.swift
//  Shopy
//
//  Created by Mohamed Adel on 18/10/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    @State private var images = ["image1", "image2", "image3"]
    
    var body: some View {
        
        NavigationStack {
            
            if homeViewModel.isLoading {
                ProgressView()
                
            } else {
                
                Group {
                    if homeViewModel.searchText.isEmpty {
                        searchableIsNotActive
                    } else {
                        searchableIsActive
                    }
                }
                .background(Color("backgroundColor"))
                .searchable(text: $homeViewModel.searchText)
                .foregroundStyle(Color.white)
                .autocorrectionDisabled(true)
                .toolbarBackground(Color(Color.accentColor))
                .toolbarBackground(.visible, for: .navigationBar)
                .onAppear {
                    UISearchBar.appearance().tintColor = .white
                }
                
            }
        }
        
    }
    
}

#Preview {
    HomeView()
}

extension HomeView {
    
    var searchableIsActive: some View {
        
        List(homeViewModel.productSearchResult) { product in
            
            HStack(alignment: .top) {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.white)
                        .frame(width: 100, height: 130)
                    
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .frame(width:90, height: 120)
                        
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 130)
                    }
                }
                
                Text(product.title)
                    .foregroundStyle(Color("textColor"))
                    .padding()
                    .lineLimit(3)
            }
        }
        .scrollIndicators(.hidden)
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        
    }
    
    
    var searchableIsNotActive: some View {
        
        ScrollView {
            
            VStack {
                
                imageSlider
                
                CategoryView(products: homeViewModel.products, categories: homeViewModel.categories)
            }
        }
        .scrollIndicators(.hidden)
        
    }
    
    var imageSlider: some View {
        
        TabView {
            ForEach(images, id: \.self) { image in
                Image(image)
                    .resizable()
            }
        }
        .frame(height: 270)
        .tabViewStyle(PageTabViewStyle())
        
    }
}


struct CategoryView: View {
    
    var products = [Product]()
    var categories = [String]()
    
    var body: some View {
        
        VStack {
            ForEach(categories, id: \.self) { category in
                
                let products = products.filter{ $0.category == category }
                
                VStack {
                    HStack {
                        Text(category.capitalized)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("textColor"))
                        
                        Spacer()
                        
                        NavigationLink {
                            ProductList(products: products)
                                .navigationTitle(category.capitalized)
                                .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            Text("View All")
                                .foregroundStyle(Color.accentColor)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ProductHStack(products: products)
                    
                }
            }
        }
    }
}


struct ProductHStack: View {
    
    var products = [Product]()
    
    var body: some View {
        
        ScrollView(.horizontal) {
            
            HStack {
                ForEach(products.prefix(4)) { product in
                    
                    ProductCell(product: product)
                        .frame(width: 150)
                }
            }
            .padding(.horizontal, 3)
            .padding(.bottom, 10)
            
        }
        .scrollIndicators(.hidden)
        .frame(height: 250)
        
    }
    
}


