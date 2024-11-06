//
//  SignInViewModel.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/10/24.
//

import Foundation
import FirebaseAuth

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var senha: String = ""
    @Published var confirmarSenha: String = ""
    
    func registrar() {
        Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
            if let error = error {
                //self.errorMessage = "Error: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            } else {
                print("Usuário registrado com sucesso")
            }
            
            //voltar tela
            //verificar erro de usuario
            //implementar mensagem de erro
        }
    }
}
