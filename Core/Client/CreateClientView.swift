//
//  CreateClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import SwiftUI

struct CreateClientView: View {
    @EnvironmentObject private var vm: ClientViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                CreateTextfield(text: $vm.name, title: "Name", placeholder: "Name")
                CreateTextfield(text: $vm.phoneNumber, title: "Phone number", placeholder: "Phone number")
                CreateTextfield(text: $vm.nickname, title: "Nickname", placeholder: "Nickname")
                Toggle("Favourite", isOn: $vm.isFavourite)
                    .tint(.indigo)
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.save(name: vm.name, phoneNumber: vm.phoneNumber, nickname: vm.nickname, isFavourite: vm.isFavourite)
                        dismiss()
                    } label: {
                      Text("Save")
                            .font(.headline)
                            .foregroundStyle(.indigo)
                    }
                }
            }
        }
    }
}

struct CreateClientView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateClientView()
        }
        .environmentObject(ClientViewModel(firebaseService: dev.firebaseService))
    }
}
