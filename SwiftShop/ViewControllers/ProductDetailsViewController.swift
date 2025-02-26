//
//  ProductDetailsViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/12/24.
//

import SwiftUI

struct ProductDetailsViewController: View {
    
    @ObservedObject var viewModel: ProductsDetailsViewModel
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            VStack {
                
                if (viewModel.product.discount > 0) {
                    VStack {
                        Text("\(viewModel.product.discount)%")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            
                    }
                    .frame(width: 50, height: 25)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(5)
                }
                
                ZStack {
                    Circle()
                        .fill(Color("SecondaryColor")).opacity(0.5)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    
                    Circle()
                        .fill(Color("SecondaryColor")).opacity(0.2)
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                    
                    Image(viewModel.product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.6)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
            
            VStack {
                
                VStack {
                    Text(viewModel.product.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(viewModel.product.description)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .lineLimit(4)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<5, id: \.self) { index in
                            Image(systemName: index < viewModel.product.rating ? "star.fill" : "star")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.yellow)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("R$\(formatPriceBRL(viewModel.product.price))")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                await viewModel.addItemToCart()                                
                                showModal = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "cart.fill.badge.plus")
                                    .foregroundColor(Color(.white))
                                
                                Text("Comprar")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(.white))
                            }
                            .frame(width: 110, height: 40)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .background(Color(.white))
                .cornerRadius(40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LightGray"))
            .cornerRadius(40)
        }
    }
}

struct ProductDetailsViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsPreview()
    }
}

struct ProductDetailsPreview: View {
    @State private var showModal = true
    
    var body: some View {
        ProductDetailsViewController(viewModel: ProductsDetailsViewModel(product: mockProduct), showModal: $showModal)
    }
}
