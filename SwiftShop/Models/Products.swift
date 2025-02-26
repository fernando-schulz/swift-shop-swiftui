//
//  Products.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/11/24.
//

import Foundation

struct Product: Identifiable, Hashable {
    var id: String
    var name: String
    var price: Double
    var discount: Int
    var rating: Int
    var description: String
    var image: String
    
    init (id: String, name: String, price: Double, discount: Int, rating: Int, description: String, image: String) {
        self.id = id
        self.name = name
        self.price = price
        self.discount = discount
        self.rating = rating
        self.description = description
        self.image = image
    }
}
