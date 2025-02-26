//
//  CartProduct.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/01/25.
//

import Foundation

struct CartProduct: Identifiable {
    
    var id: String
    var name: String
    var quantity: Int
    var price: Double
    var totalPrice: Double
    var image: String
    
    init(id: String, name: String, quantity: Int, price: Double, totalPrice: Double, image: String) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
        self.totalPrice = totalPrice
        self.image = image
    }
}
