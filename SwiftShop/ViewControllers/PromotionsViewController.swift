//
//  PromotionsViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/11/24.
//

import SwiftUI

struct PromotionsViewController: View {
    
    @ObservedObject var viewModel: ProductsViewModel
    
    var body: some View {
        VStack {
            
            VStack {
                //Apenas para o scroll não passar "por trás" do header
            }
            .frame(height: 1)
            
            ListProductsView(products: viewModel.products)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LightGray"))
    }
}

struct PromotionsViewController_Previews: PreviewProvider {
    static var previews: some View {
        PromotionsViewController(viewModel: ProductsViewModel(categories: mockCategories, products: mockProducts))
    }
}
