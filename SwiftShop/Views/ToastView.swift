//
//  ToastView.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 12/11/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 40)
            .multilineTextAlignment(.center)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
