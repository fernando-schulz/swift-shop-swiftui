//
//  ListProductsView.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 12/12/24.
//

import SwiftUI

class ProductSelectionManager: ObservableObject {
    @Published var selectedProduct: Product? = nil
    @Published var showModalProductDetail: Bool = false
}

struct ListProductsView: View {
    
    var products: [Product]
    @StateObject private var productSelectionManager = ProductSelectionManager()
    @State private var showToast: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            let totalWidth = geometry.size.width
            let cardWidth: CGFloat = 150
            let spacing = calculateSpacing(totalWidth: totalWidth, cardWidth: cardWidth)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: spacing)], spacing: 16) {
                    ForEach(products, id: \.self) { product in
                        Button(action: {
                            print("Produto \(product.name)")
                            productSelectionManager.selectedProduct = product
                            productSelectionManager.showModalProductDetail = true
                        }) {
                            ProductCardView(product: product)
                        }
                    }
                }
                .padding(.horizontal, spacing)
            }
        }
        .sheet(isPresented: $productSelectionManager.showModalProductDetail) {
            if let selectedProduct = productSelectionManager.selectedProduct {
                ProductDetailsViewController(
                    viewModel: {
                        let productDetailsViewModel = ProductsDetailsViewModel(product: selectedProduct)
                        productDetailsViewModel.onProductAdded = {
                            showToast = true
                        }
                        return productDetailsViewModel
                    }(),
                    showModal: $productSelectionManager.showModalProductDetail
                )
            } else {
                Text("Nenhum produto selecionado.")
            }
        }
        .overlay(
            Group {
                if showToast {
                    ToastView(message: "Produto adicionado com sucesso!")
                        .position(x: UIScreen.main.bounds.width / 2, y: 0)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showToast = false
                            }
                        }
                }
            }
        )
    }
    
    func calculateSpacing(totalWidth: CGFloat, cardWidth: CGFloat) -> CGFloat {
        let numberOfCards = floor(totalWidth / cardWidth)
        let totalSpacing = totalWidth - (numberOfCards * cardWidth)
        let spacing = totalSpacing / (numberOfCards + 1)
        return max(spacing, 5)
    }
}

struct ListProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ListProductsView(products: mockProducts)
    }
}
