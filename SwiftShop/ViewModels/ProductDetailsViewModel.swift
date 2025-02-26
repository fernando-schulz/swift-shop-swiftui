//
//  ProductDetailsViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProductsDetailsViewModel: ObservableObject {
    
    @Published var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var onProductAdded: (() -> Void)?
    
    func addItemToCart() async {
        guard let user = Auth.auth().currentUser else {
            print("Usuário não autenticado")
            return
        }
        
        let db = Firestore.firestore()
        let cartRef = db.collection("users").document(user.uid).collection("cart")
        
        let productData: [String: Any] = [
            "product_id": product.id,
            "quantity": 1
        ]
        
        do {
            try await cartRef.document(product.id).setData(productData, merge: true)
            print("Produto adicionado/atualizado no carrinho com sucesso!")
            onProductAdded?()
        } catch {
            print("Erro ao adicionar item ao carrinho: \(error.localizedDescription)")
        }
    }
}
