//
//  ProductsViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 25/11/24.
//

import FirebaseFirestore

class ProductsViewModel: ObservableObject {
    
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    var lastCategoryId: String?
    
    private let db = Firestore.firestore()
    
    init(categories: [Category] = [], products: [Product] = [], isPromotionScreen: Bool = false) {
        self.products = products
        self.categories = categories
        if (!isPromotionScreen) {
            fetchCategories()
        }
        fetchProducts(categoryId: nil, isPromotionScreen: isPromotionScreen)
    }
    
    func fetchCategories() {
        db.collection("categories").getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar categorias: \(error)")
                return
            }
            
            self.categories = snapshot?.documents.compactMap { document in
                let data = document.data()
                guard
                    let id = data["id"] as? String,
                    let icon = data["icon"] as? String,
                    let name = data["name"] as? String
                else { return nil }
                
                return Category(id: id, icon: icon, name: name)
            } ?? []
        }
    }
    
    func fetchProducts(categoryId: String?, isPromotionScreen: Bool) {
        let query: Query = isPromotionScreen
            ? db.collection("products").whereField("discount", isGreaterThan: 0)
            : (categoryId != nil && categoryId != lastCategoryId
                ? db.collection("products").whereField("categorie", isEqualTo: Int(categoryId ?? "") ?? 0)
                : db.collection("products"))
        
        query.getDocuments { snapshot, error in
            if let error = error {
                print("Erro ao buscar produtos: \(error)")
                return
            }
            
            if categoryId != nil {
                if (categoryId == self.lastCategoryId) {
                    self.lastCategoryId = nil
                } else {
                    self.lastCategoryId = categoryId
                }
            }
            
            self.products = snapshot?.documents.compactMap { document in
                let data = document.data()
                guard
                    let id = data["id"] as? String,
                    let name = data["name"] as? String,
                    let description = data["description"] as? String,
                    let image = data["image"] as? String,
                    let price = data["price"] as? Double,
                    let discount = data["discount"] as? Int,
                    let rating = data["rating"] as? Int
                else { return nil }
                
                return Product(id: id, name: name, price: price, discount: discount, rating: rating, description: description, image: image)
            } ?? []
        }
    }
}
