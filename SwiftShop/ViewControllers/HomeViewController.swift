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
    
    var body: some View {
        VStack {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LightGray"))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("Sair") {
                        sessionManager.isLogged = false
                    }
                } label: {
                    Label("Menu", systemImage: "ellipsis.circle")
                }
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
