//
//  LoginViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/10/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var usuario: String = ""
    @Published var senha: String = ""
    @Published var errorMessage: String?
    @Published var showErrorAlert: Bool = false
    @Published var isLogged: Bool = false
    @Published var showModalSignIn: Bool = false
    
    func login() {
        Auth.auth().signIn(withEmail: usuario, password: senha) { authResult, error in
            if (error != nil) {
                self.errorMessage = "Não foi possível autenticar, verifique seu e-mail e senha"
                self.showErrorAlert = true
                return
            }
            
            self.isLogged = true
        }
    }
    
    func toggleShowModalSignIn() {
        showModalSignIn.toggle()
    }
}
