//
//  HomeView.swift
//  Shopy
//
//  Created by Mohamed Adel on 18/10/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            if homeViewModel.isLoading {
                ProgressView()
                
            } else {
                
                ZStack {
                    
                    searchableIsNotActive
                    
                    if !homeViewModel.searchText.isEmpty {
                        SearchableIsActive(homeViewModel: homeViewModel)
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
        
    var searchableIsNotActive: some View {
        
        ScrollView {
            
            VStack {
                
                imageSlider
                
                CategoryView(products: homeViewModel.products, categories: homeViewModel.categories)
            }
        }
        .scrollIndicators(.hidden)
        .onTapGesture {
            hideKeyboard()
        }
        
    }
    
    var imageSlider: some View {
        
        TabView {
            ForEach(homeViewModel.imageSliderData, id: \.id) { product in
                NavigationLink {
                    ProductDetailsView(productID: product.id)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Image(product.imageName)
                        .resizable()
                }
            }
        }
        .frame(height: 200)
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
                    
                    ProductHList(products: products)
                    
                }
            }
        }
    }
}



struct SearchableIsActive: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @Environment(\.dismissSearch) var dismissSearch

    
    var body: some View {
        
        List(homeViewModel.productSearchResult) { product in
            
            Button(action: {
                homeViewModel.searchSelectedProduct = product

                Task {
                    try await Task.sleep(nanoseconds: 1_000_000)
                    dismissSearch()
                }
            }, label: {
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

            })

            
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .listStyle(.grouped)
        .navigationDestination(item: $homeViewModel.searchSelectedProduct) { product in
            ProductDetailsView(productID: product.id)
                .navigationBarTitleDisplayMode(.inline)
        }

    }
}



