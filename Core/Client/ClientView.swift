//
//  ClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ClientView: View {
    @EnvironmentObject var viewModel: ClientViewModel
    @State private var isShowNewClient = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Clients")
            List {
                Section(viewModel.isFavourite ? "Favourites" : "All") {
                    ForEach(viewModel.filteredClients) { client in
                        ZStack(alignment: .leading) {
                            if viewModel.filteredClients.isEmpty {
                                Text("No clients available")
                            } else {
                                NavigationLink(destination: ClientDetailView(client: client)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                ClientCellView(client: client)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .overlay(alignment: .bottomTrailing, content: {
                HStack {
                    SearchBarView(searchText: $viewModel.searchText)
                    Button {
                        isShowNewClient.toggle()
                    } label: {
                        HStack {
                            CreateButton()
                                .padding()
                        }
                    }
                }
            })
            .sheet(isPresented: $isShowNewClient, content: {
                NavigationStack {
                    CreateClientView()
                }
                .environmentObject(viewModel)
            })
            .font(.title2)
            .fontWeight(.semibold)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        ClientView(showSideMenu: .constant(false))
            .environmentObject(ClientViewModel(firebaseService: FirebaseService()))
    }
}
