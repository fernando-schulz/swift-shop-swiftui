//
//  CustomTextField.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 31/10/24.
//

import SwiftUI

struct CustomTextField<Content: View>: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    //var isSecure: Bool = false
    let content: () -> Content
    
    private var shouldShowLabel: Bool {
        !text.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            if shouldShowLabel {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.5), value: text)
            }
            
            content()
        }
        .frame(height: 25)
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
    }
}

struct CustomTextField_Previews: PreviewProvider {
    @State static var stateTest: String = "Teste CustomTextField"
    
    static var previews: some View {
        CustomTextField(label: "Teste", placeholder: "Teste CustomTextField", text: $stateTest) {
            TextField("Usuário", text: $stateTest)
        }
    }
}
