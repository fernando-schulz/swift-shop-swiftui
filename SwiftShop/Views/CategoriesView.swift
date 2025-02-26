//
//  CategoriesView.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 20/11/24.
//

import SwiftUI

struct CategoriesView: View {
    
    let category: Category
    let onTap: (String) -> Void
    
    var body: some View {
        Button(action: {
            onTap(category.id)
        }) {
            HStack {
                Image(systemName: category.icon)
                    .foregroundColor(Color("Text"))
                
                Text(category.name)
                    .fontWeight(.semibold)
                    .font(.system(size: 14))
                    .foregroundColor(Color("Text"))
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("PrimaryColor"))
                    .shadow(radius: 5, x: 5, y: 5)
                    .frame(width: 140, height: 40)
            )
            .frame(width: 140, height: 40, alignment: .top)
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(category: mockCategory, onTap: { categoryId in
            print("Tapped category with ID: \(categoryId)")
        })
        //.background(Color("PrimaryColor"))
            .previewLayout(.sizeThatFits)
    }
}
