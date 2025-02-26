//
//  SignInViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 28/10/24.
//

import SwiftUI

struct SignUpViewController: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    @Binding var showModal: Bool
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Registrar")
                        .foregroundColor(Color("Text"))
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                VStack {
                    CustomTextField(label: "E-Mail", placeholder: "E-Mail", text: $viewModel.email) {
                        TextField("E-Mail", text: $viewModel.email)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.top, 6)
                    .padding(.bottom, 6)
                    
                    CustomTextField(label: "Senha", placeholder: "Senha", text: $viewModel.senha) {
                        SecureField("Senha", text: $viewModel.senha)
                            .textContentType(.oneTimeCode)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.bottom, 6)
                    
                    CustomTextField(label: "Confirmar Senha", placeholder: "Confirmar Senha", text: $viewModel.confirmarSenha) {
                        SecureField("Confirmar Senha", text: $viewModel.confirmarSenha)
                            .textContentType(.oneTimeCode)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.bottom, 10)
                    
                    Button(action: {
                        Task {
                            await viewModel.registrar()
                            
                            if viewModel.errorMessage != nil {
                                showErrorAlert = true
                            } else {
                                showModal = false
                            }
                        }
                    }) {
                        Text("Registrar")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: 150, maxHeight: 40)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(20)
                    .padding(.bottom, 6)
                }
                .padding()
                .background(.white)
                .cornerRadius(20)
                
                Spacer()
            }
            .padding(.top, getSafeAreaInsets()?.top ?? 0)
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Erro ao registrar"),
                    message: Text(viewModel.errorMessage ?? "Erro ao registrar"),
                    dismissButton: .default(Text("Fechar"), action: {
                        viewModel.errorMessage = nil
                        showErrorAlert = false
                    })
                )
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(15)
        .background(Color("LightGray"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignInViewController_Previews: PreviewProvider {
    static var previews: some View {
        SignInPreview()
    }
}

struct SignInPreview: View {
    @State private var showModal = true
    
    var body: some View {
        SignUpViewController(viewModel: SignUpViewModel(), showModal: $showModal)
    }
}
