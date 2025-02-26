//
//  HomeViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 15/11/24.
//

import Foundation
import FirebaseAuth

class HomeViewModel: ObservableObject {
    
    private var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            sessionManager.isLogged = false
        } catch let signOutError as NSError {
            print("Erro ao deslogar: \(signOutError.localizedDescription)")
        }
    }
    
}
