//
//  LoginViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/10/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    private let sessionManager: SessionManager
    
    @Published var usuario: String = ""
    @Published var senha: String = ""
    @Published var errorMessage: String?
    @Published var showErrorAlert: Bool = false
    @Published var showModalSignIn: Bool = false
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func login() {
        Auth.auth().signIn(withEmail: usuario, password: senha) { authResult, error in
            if (error != nil) {
                self.errorMessage = "Não foi possível autenticar, verifique seu e-mail e senha"
                self.showErrorAlert = true
                return
            }
            
            //self.isLogged = true
            self.sessionManager.isLogged = true
        }
    }
    
    func toggleShowModalSignIn() {
        showModalSignIn.toggle()
    }
    
    func verifyUserIsLogged() {
        if Auth.auth().currentUser != nil {
            self.sessionManager.isLogged = true
        }
    }
}
