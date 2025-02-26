//
//  ProductCardView.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/11/24.
//

import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            
            HStack {
                if (product.discount > 0) {
                    VStack {
                        Text("\(product.discount)%")
                            .font(.system(size: 10))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .frame(width: 30, height: 15)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(5)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .fill(Color("SecondaryColor").opacity(0.2))
                    .frame(width: 110, height: 110)
                
                Circle()
                    .fill(Color("SecondaryColor").opacity(0.5))
                    .frame(width: 85, height: 85)
                
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
            }
            
            Spacer()
            
            Text(product.name)
                .lineLimit(1)
                .font(.caption2)
                .foregroundColor(Color("Text"))
            
            Spacer()
            
            Text("R$\(formatPriceBRL(product.price))")
                .fontWeight(.bold)
                .font(.caption)
                .foregroundColor(Color("Text"))
            
            HStack {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: index < product.rating ? "star.fill" : "star")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.yellow)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 5, x: 5, y: 5)
                .frame(width: 150, height: 225)
        )
        .frame(width: 150, height: 225)
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: mockProduct)
            .previewLayout(.sizeThatFits)
            .background(.black)
    }
}
