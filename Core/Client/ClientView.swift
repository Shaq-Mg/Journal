//
//  ClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import SwiftUI

struct ClientView: View {
    @State private var isShowNewClient = false
    @EnvironmentObject var viewModel: ClientViewModel
    
    var body: some View {
        VStack {
            HeaderView(onDismiss: true, title: "Clients")
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
                                ClientRowView(client: client)
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
                            CreateNavButton()
                                .padding()
                        }
                    }
                }
            })
            .onAppear { viewModel.fetchClients() }
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

struct ClientView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ClientView()
        }
        .environmentObject(ClientViewModel(firebaseService: dev.firebaseService))
    }
}

struct ClientRowView: View {
    let client: Client
    var body: some View {
        HStack {
            Circle()
                .frame(width: 35, height: 35)
                .foregroundStyle(.secondary)
                .overlay {
                    Text((client.name.prefix(1).capitalized))
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 6) {
                Text(client.name)
                    .font(.system(size: 18, design: .rounded).bold())
            }
            Spacer()
            if client.isFavourite {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.indigo)
            }
        }
    }
}
