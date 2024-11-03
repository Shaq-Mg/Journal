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
            Section("Information") {
                SelectDetailView(title: "Phone number", description: client.phoneNumber)
                SelectDetailView(title: "Nickname", description: client.nickname ?? "")
                SelectDetailView(title: "Favourite", description: client.isFavourite.description)
            }
            .fontWeight(.semibold)
        }
        .navigationTitle(client.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
