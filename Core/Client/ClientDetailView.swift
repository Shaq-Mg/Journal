//
//  ClientDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
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
                SelectDetailView(title: "Phone number", description: client.phoneNumber)
                SelectDetailView(title: "Nickname", description: client.nickname ?? "")
                SelectDetailView(title: "Favourite", description: client.isFavourite.description)
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
                    .foregroundStyle(Color.accentColor)
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

#Preview {
    NavigationStack {
        ClientDetailView(client: Client(name: "Melo Ball", phoneNumber: "01000000080", nickname: nil, isFavourite: true))
            .environmentObject(ClientViewModel(firebaseService: FirebaseService()))
    }
}
