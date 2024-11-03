//
//  ClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ClientView: View {
    @EnvironmentObject var clientVM: ClientViewModel
    @State private var isShowNewClient = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Clients")
            clientListHeader
            Spacer()
            if clientVM.filteredClients.isEmpty {
                Text("No clients available")
                    .fontWeight(.semibold)
                Spacer()
            } else {
                List {
                    ForEach(clientVM.filteredClients) { client in
                        ZStack {
                            NavigationLink(destination: ClientDetailView(client: client)) {
                                EmptyView()
                            }
                            .environmentObject(clientVM)
                            .opacity(0)
                            ClientCellView(client: client)
                        }
                    }
                    .onDelete(perform: clientVM.deleteClient)
                }
                .listStyle(.plain)
            }
        }
        .onAppear(perform: clientVM.fetchClientsWithListener)
        .font(.title2)
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .bottomTrailing, content: {
            HStack {
                SearchBarView(searchText: $clientVM.searchText)
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
            .environmentObject(clientVM)
        })
    }
}

#Preview {
    NavigationStack {
        ClientView(showSideMenu: .constant(false))
            .environmentObject(ClientViewModel(firebaseService: FirebaseService()))
    }
}

extension ClientView {
    private var clientListHeader: some View {
        HStack {
            Button(action: {
                clientVM.isFavourite.toggle()
            }, label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundStyle(Color(.systemGray))
            })
            
            Spacer()
            
            Image(systemName: "chevron.down")
                .foregroundStyle(Color.accentColor)
            
                .rotationEffect(Angle(degrees: clientVM.isFavourite ? 180 : 1.0))
            
            Text(clientVM.isFavourite ? "" : "All")
        }
        .padding(.top, 8)
        .padding(.horizontal)
        .font(.system(size: 18, weight: .semibold))
        .animation(.easeInOut(duration: 0.75), value: clientVM.isFavourite)
    }
}
