//
//  Category.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 20/11/24.
//

import Foundation

struct Category: Identifiable {
    var id: String
    var icon: String
    var name: String
    
    init(id: String, icon: String, name: String) {
        self.id = id
        self.icon = icon
        self.name = name
    }
}
