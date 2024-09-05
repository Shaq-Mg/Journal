//
//  CreateClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct CreateClientView: View {
    @EnvironmentObject private var vm: ClientViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                headerView
                
                CreateTextfield(text: $vm.name, title: "Name", placeholder: "Name")
                CreateTextfield(text: $vm.phoneNumber, title: "Phone number", placeholder: "Phone number")
                CreateTextfield(text: $vm.nickname, title: "Nickname", placeholder: "Nickname")
                Toggle("Favourite", isOn: $vm.isFavourite)
                    .tint(.indigo)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        CreateClientView()
            .environmentObject(ClientViewModel(firebaseService: FirebaseService()))
    }
}

extension CreateClientView {
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            Spacer()
            ReusableCapsule()
            Spacer()
            Button {
                vm.create(name: vm.name, phoneNumber: vm.phoneNumber, nickname: vm.nickname, isFavourite: vm.isFavourite)
                dismiss()
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundStyle(.indigo)
            }
        }
        .padding(.vertical, 16)
    }
}
