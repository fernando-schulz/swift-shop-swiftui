//
//  ProductsViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/11/24.
//

import SwiftUI

struct ProductsViewController: View {
    
    @ObservedObject var viewModel: ProductsViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(viewModel.categories) { category in
                        CategoriesView(category: category) { categoryId in
                            viewModel.fetchProducts(categoryId: categoryId, isPromotionScreen: false)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            }
            
            Spacer()
            
            ListProductsView(products: viewModel.products)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LightGray"))
    }
}

struct ProductsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProductsViewController(viewModel: ProductsViewModel(categories: mockCategories, products: mockProducts))
    }
}
