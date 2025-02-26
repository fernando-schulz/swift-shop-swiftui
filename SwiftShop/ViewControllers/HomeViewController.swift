//
//  HomeViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 29/10/24.
//

import SwiftUI

struct HomeViewController: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProductsViewController(viewModel: ProductsViewModel())
                .tabItem {
                    Image(systemName: "desktopcomputer")
                    Text("Produtos")
                }
                .tag(1)
            
            CartViewController(viewModel: CartViewModel(), selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Carrinho")
                }
                .tag(2)
            
            PromotionsViewController(viewModel: ProductsViewModel(isPromotionScreen: true))
                .tabItem {
                    Image(systemName: "tag.fill")
                    Text("Promoções")
                }
                .tag(3)
        }
        .accentColor(Color("PrimaryColor"))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline) //Diminui tamanho da barra de navegação, por padrão ela ocupa muito espaço
        .toolbar {
            // Botão de menu no canto superior direito
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Sair") {
                        viewModel.signOut()
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                }
            }
            // Logo no centro da barra de navegação
            ToolbarItem(placement: .principal) {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
            }
        }
    }
}


struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        
        let mockSessionManager = SessionManager()
        mockSessionManager.isLogged = false
        
        return HomeViewController(viewModel: HomeViewModel(sessionManager: mockSessionManager))
    }
}
