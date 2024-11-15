//
//  ViewExtension.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 12/11/24.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: Double = 2.0) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                ToastView(message: message)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isPresented.wrappedValue = false
                            }
                        }
                    }
            }
        }
    }
}
