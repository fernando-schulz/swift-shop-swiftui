//
//  CartViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/01/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CartViewModel: ObservableObject {
    
    @Published var cartProducts: [CartProduct] = [] {
        didSet {
            calculateTotal()
        }
    }
    @Published var totalValue: Double = 0.0
    @Published var showDeleteAlert: Bool = false
    @Published var selectedProductId: String?
    @Published var isLoading: Bool = false
    
    init(cartProducts: [CartProduct] = []) {
        self.cartProducts = cartProducts
    }
    
    func getItensCart() {
        isLoading = true
        guard let user = Auth.auth().currentUser else {
            print("Usuário não autenticado")
            isLoading = false
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("cart").getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar produtos do carrinho: \(error)")
                self.isLoading = false
                return
            }
            
            let cartItems = snapshot?.documents ?? []
            
            self.cartProducts = []
            
            if cartItems.isEmpty {
                self.isLoading = false
                return
            }
            
            let group = DispatchGroup()
            
            for document in cartItems {
                let data = document.data()
                
                guard
                    let product_id = data["product_id"] as? String,
                    let quantity = data["quantity"] as? Int
                else { continue }
                
                group.enter()
                
                db.collection("products").whereField("id", isEqualTo: product_id).getDocuments { productsSnapshot, error in
                    defer { group.leave() }
                    
                    if let error = error {
                        print("Erro ao buscar informações do produto do carrinho: \(error)")
                        return
                    }
                    
                    if let productDocument = productsSnapshot?.documents.first {
                        let productData = productDocument.data()
                        
                        guard
                            let name = productData["name"] as? String,
                            let image = productData["image"] as? String,
                            let price = productData["price"] as? Double
                        else { return }
                        
                        let cartProduct = CartProduct(
                            id: product_id,
                            name: name,
                            quantity: quantity,
                            price: price,
                            totalPrice: Double(quantity) * price,
                            image: image
                        )
                        
                        DispatchQueue.main.async {
                            self.cartProducts.append(cartProduct)
                        }
                    }
                }
            }
            
            group.notify(queue: .main) {
                self.isLoading = false
            }
        }
    }
    
    func updateQuantity(productId: String, newQuantity: Int) {
        if let index = cartProducts.firstIndex(where: { $0.id == productId }) {
            
            guard let user = Auth.auth().currentUser else {
                print("Usuário não autenticado")
                return
            }
            
            let db = Firestore.firestore()
            let productRef = db.collection("users").document(user.uid).collection("cart").document(productId)
            
            if (cartProducts[index].quantity == 1 && newQuantity < 0) {
                selectedProductId = productId
                showDeleteAlert = true
            } else {
                let qtd: Int = cartProducts[index].quantity + newQuantity
                
                productRef.updateData(["quantity": qtd]) { error in
                    if let error = error {
                        print("Não foi possível atualizar a quantidade no firebase. Log: \(error.localizedDescription)")
                        return
                    }
                }
                
                cartProducts[index].quantity = qtd
                calculateTotal()
            }
        }
    }
    
    private func calculateTotal() {
        totalValue = cartProducts.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }
    
    func deleteProduct(productId: String) {
        selectedProductId = nil
        if let index = cartProducts.firstIndex(where: { $0.id == productId }) {
            
            guard let user = Auth.auth().currentUser else {
                print("Usuário não autenticado")
                return
            }
            
            let db = Firestore.firestore()
            let productRef = db.collection("users").document(user.uid).collection("cart").document(productId)
            
            productRef.delete() { error in
                if let error = error {
                    print("Não foi possível excluir o item no firebase. Log: \(error.localizedDescription)")
                }
            }
            
            cartProducts.remove(at: index)
            calculateTotal()
        }
    }
    
    func checkOut() {
        guard let user = Auth.auth().currentUser else {
            print("Usuário não autenticado")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("cart").getDocuments() { snapshot, error in
            if let error = error {
                print("Erro ao buscar produtos do carrinho: \(error)")
                self.isLoading = false
                return
            }
            
            let cartItems = snapshot?.documents ?? []
            
            if cartItems.isEmpty {
                return
            }
            
            for document in cartItems {
                document.reference.delete { error in
                    if let error = error {
                        print("Erro ao excluir item do carrinho: \(error)")
                    }
                }
            }
        }
    }
}
