//
//  CreateClientView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct CreateClientView: View {
    @EnvironmentObject private var viewModel: ClientViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                headerView
                
                CreateTextfield(text: $viewModel.name, title: "Name", placeholder: "Name")
                CreateTextfield(text: $viewModel.phoneNumber, title: "Phone number", placeholder: "Phone number")
                CreateTextfield(text: $viewModel.nickname, title: "Nickname", placeholder: "Nickname")
                Toggle("Favourite", isOn: $viewModel.isFavourite)
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
                if !viewModel.name.isEmpty && !viewModel.phoneNumber.isEmpty {
                    viewModel.create(name: viewModel.name, phoneNumber: viewModel.phoneNumber, nickname: viewModel.nickname, isFavourite: viewModel.isFavourite)
                    dismiss()
                }
            } label: {
                Text("Save")
                    .font(.headline)
                    .foregroundStyle(.indigo)
            }
        }
        .padding(.vertical, 16)
    }
}
