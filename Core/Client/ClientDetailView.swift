//
//  ClientDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import SwiftUI

struct ClientDetailView: View {
    @EnvironmentObject private var vm: ClientViewModel
    @State private var showConfirmation = false
    @Environment(\.dismiss) private var dismiss
    let client: Client
    
    var body: some View {
        List {
            Section("General") {
                HStack {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.secondary)
                        .overlay {
                            Text((client.name.prefix(1).capitalized))
                                .font(.title3.bold())
                                .foregroundStyle(.white)
                        }
                    Text(client.name)
                        .font(.title2.bold())
                }
                ClientDetailSection(title: "Phone number:", section: client.phoneNumber)
                ClientDetailSection(title: "Nickname", section: client.nickname ?? "")
                ClientDetailSection(title: "Favourite", section: client.isFavourite.description)
            }
            .fontWeight(.semibold)
            Section("Update") {
                Button {
                    showConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "minus.circle")
                        Text("Delete")
                    }
                    .font(.headline)
                    .foregroundStyle(.indigo)
                    .padding(.vertical)
                }
            }
        }
        .confirmationDialog("Delete Client", isPresented: $showConfirmation) {
            Button("Yes") { vm.delete(clientToDelete: client) }
        } message: {
            Text("Are you sure you want to delete this client?")
        }
        .navigationTitle(client.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }

    }
}

struct ClientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailView(client: dev.client)
    }
}

struct ClientDetailSection: View {
    let title: String
    let section: String
    var body: some View {
        HStack {
            Text(title)
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(section)
        }
    }
}
