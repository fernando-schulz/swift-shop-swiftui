//
//  Utils.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 05/11/24.
//

import Foundation
import UIKit

func getSafeAreaInsets() -> UIEdgeInsets? {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
        return nil
    }
    
    return window.safeAreaInsets
}

func formatPriceBRL(_ price: Double) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "pt_BR")
    formatter.numberStyle = .currency
    formatter.currencySymbol = "R$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    return formatter.string(from: NSNumber(value: price))?.replacingOccurrences(of: "R$", with: "") ?? "0,00"
}
