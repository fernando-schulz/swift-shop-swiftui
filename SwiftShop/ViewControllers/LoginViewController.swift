import SwiftUI

struct LoginViewController: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var viewModel: LoginViewModel
    @State private var showToast = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BackgroundLogin"))
                
                Spacer()
                
                VStack {
                    
                    CustomTextField(label: "Usuário", placeholder: "Usuário", text: $viewModel.usuario) {
                        TextField("Usuário", text: $viewModel.usuario)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.bottom, 6)
                    
                    CustomTextField(label: "Senha", placeholder: "Senha", text: $viewModel.senha) {
                        SecureField("Senha", text: $viewModel.senha)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.bottom, 6)
                    
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Entrar")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .frame(width: 200, height: 60)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(30)
                    .padding(.bottom, 6)
                    
                    Button(action: {
                        viewModel.toggleShowModalSignIn()
                    }) {
                        Text("Registrar")
                            .foregroundColor(.white)
                    }
                    .frame(width: 150, height: 40)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(20)
                    .padding(.bottom, 6)
                    .sheet(isPresented: $viewModel.showModalSignIn) {
                        SignUpViewController(viewModel: {
                            let signUpViewModel = SignUpViewModel()
                            signUpViewModel.onUserRegistered = {
                                showToast = true
                            }
                            return signUpViewModel
                        }(), showModal: $viewModel.showModalSignIn)
                    }
                    .toast(isPresented: $showToast, message: "Usuário cadastrado com sucesso!")
                    
                    NavigationLink(destination: HomeViewController(viewModel: HomeViewModel(sessionManager: sessionManager)).environmentObject(sessionManager),
                                   isActive: $sessionManager.isLogged) {
                        EmptyView()
                    }
                }
                .padding()
                .padding(.bottom, 20)
                .padding(.top, 20)
                .background(Color("LightGray"))
                .cornerRadius(30)
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(
                        title: Text("Erro ao autenticar"),
                        message: Text(viewModel.errorMessage ?? "Ocorreu um erro"),
                        dismissButton: .default(Text("Fechar"), action: {
                            viewModel.errorMessage = nil
                            viewModel.showErrorAlert = false
                        })
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("BackgroundLogin"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct LoginViewController_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockSessionManager = SessionManager()
        mockSessionManager.isLogged = false
        
        return LoginViewController(viewModel: LoginViewModel(sessionManager: mockSessionManager)
        )
    }
}
