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
    @Published var errorMessage: String? = nil
    //@Published var showErrorAlert: Bool = false
    
    var onUserRegistered: (() -> Void)?
    
    func registrar() async {
        
        if email.isEmpty {
            self.errorMessage = "Informe o e-mail"
            return
        }
        
        if senha.isEmpty {
            self.errorMessage = "Informe a senha"
            return
        }
        
        if confirmarSenha.isEmpty {
            self.errorMessage = "Confirme a senha"
            return
        }
        
        if senha != confirmarSenha {
            self.errorMessage = "As senhas informadas não estão iguais"
            return
        }
        
        do {
            _ = try await createUser(withEmail: email, password: senha)
            errorMessage = nil
            onUserRegistered?()
        } catch {
            errorMessage = "Erro: \(error.localizedDescription)"
        }
        
        /*Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.errorMessage = "Erro: \(error.localizedDescription)"
            } else {
                print("Usuário registrado com sucesso")
                self.onUserRegistered?()
            }
        }*/
    }
    
    private func createUser(withEmail email: String, password: String) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let authResult = authResult {
                    continuation.resume(returning: authResult)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirebaseAuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Erro inesperado na criação do usuário"]))
                }
            }
        }
    }
}
