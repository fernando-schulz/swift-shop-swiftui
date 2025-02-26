//
//  CartViewController.swift
//  SwiftShop
//
//  Created by Fernando Schulz on 16/11/24.
//

import SwiftUI

struct CartViewController: View {
    
    @ObservedObject var viewModel: CartViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            
            if viewModel.isLoading {
                ProgressView("Buscando Itens...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                
                VStack {
                    //Apenas para o scroll não passar "por trás" do header
                }
                .frame(height: 1)
                
                ScrollView {
                    if let cartProducts = viewModel.cartProducts {
                        ForEach(cartProducts) { cartProduct in
                            HStack {
                                
                                ZStack {
                                    Circle()
                                        .fill(Color("SecondaryColor").opacity(0.2))
                                        .frame(width: 80, height: 80)
                                    
                                    Circle()
                                        .fill(Color("SecondaryColor").opacity(0.5))
                                        .frame(width: 65, height: 65)
                                    
                                    Image(cartProduct.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .shadow(radius: 5, x: 5, y: 5)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 5) {
                                    Text(cartProduct.name)
                                        .foregroundColor(Color("Text"))
                                        .font(.caption)
                                    
                                    Text("R$\(formatPriceBRL(cartProduct.totalPrice))")
                                        .foregroundColor(Color("Text"))
                                        .fontWeight(.semibold)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 2) {
                                    Button(action: {
                                        viewModel.updateQuantity(productId: cartProduct.id, newQuantity: -1)
                                    }) {
                                        VStack {
                                            Image(systemName: "minus")
                                                .foregroundColor(.black)
                                        }
                                        .frame(width: 26, height: 26)
                                        .background(Color("PrimaryColor")).opacity(0.3)
                                        .cornerRadius(13)
                                        .shadow(radius: 5, x: 5, y: 5)
                                    }
                                    .alert("Tem certeza?", isPresented: $viewModel.showDeleteAlert) {
                                        Button("Cancelar", role: .cancel) {
                                            viewModel.selectedProductId = nil
                                        }
                                        Button("Remover", role: .destructive) {
                                            if let id = viewModel.selectedProductId {
                                                viewModel.deleteProduct(productId: id)
                                            }
                                        }
                                    } message: {
                                        Text("Deseja realmente remover este item do carrinho?")
                                    }
                                    
                                    Text("\(cartProduct.quantity)")
                                        .foregroundColor(Color("Text"))
                                    
                                    Button(action: {
                                        viewModel.updateQuantity(productId: cartProduct.id, newQuantity: 1)
                                    }) {
                                        VStack {
                                            Image(systemName: "plus")
                                                .foregroundColor(.black)
                                        }
                                        .frame(width: 26, height: 26)
                                        .background(Color("SecondaryColor")).opacity(0.6)
                                        .cornerRadius(13)
                                        .shadow(radius: 5, x: 5, y: 5)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .background(.white)
                            .cornerRadius(20)
                            .shadow(radius: 5, x: 5, y: 5)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack {
                    Text("R$\(formatPriceBRL(viewModel.totalValue))")
                        .fontWeight(.semibold)
                        .font(.title2)
                    
                    Spacer()
                    
                    Button(action: {
                        selectedTab = 1
                        viewModel.checkOut()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .foregroundColor(Color("Text"))
                            
                            Text("Finalizar")
                                .foregroundColor(Color("Text"))
                        }
                        .padding()
                        .frame(width: 150, height: 40)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 75)
                .background(Color("LightGray"))
                .overlay(
                    Rectangle()
                        .frame(height: 1) // Espessura da borda
                        .foregroundColor(.gray) // Cor da borda
                        .opacity(0.5),
                    alignment: .top // Alinha na parte superior
                )
                //.cornerRadius(20)
                .shadow(radius: 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("LightGray"))
        .onAppear {
            viewModel.getItensCart()
        }
    }
}

struct CartViewController_Previews: PreviewProvider {
    static var previews: some View {
        CartViewController(viewModel: CartViewModel(cartProducts: mockCartProducts), selectedTab: .constant(2))
    }
}
