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
