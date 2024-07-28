//
//  SettingsView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var showSignOutAlert = false
    @State private var showDeleteAccountAlert = false
    
    var body: some View {
        VStack {
            HeaderView(title: "Settings")
            List {
                Section("Profile information") {
                    AccountButtonView(title: "Update password", imageName: "key.fill", isPressed: { })
                    AccountButtonView(title: "Update email", imageName: "envelope.fill", isPressed: { })
                }
                
                Section("Account") {
                    AccountButtonView(title: "Delete account", imageName: "minus.circle", isPressed: { showDeleteAccountAlert.toggle() })
                    AccountButtonView(title: "Sign out", imageName: "lock.fill", isPressed: { showSignOutAlert.toggle() })
                }
            }
        }
        .confirmationDialog("Sign out", isPresented: $showSignOutAlert, titleVisibility: .visible) {
            Button("Yes", role: .destructive) {
                DispatchQueue.main.async {
                    try? viewModel.signOut()
                }
            }
        } message: {
            Text("Continue to log out this account?")
        }
        .confirmationDialog("Delete permanently", isPresented: $showDeleteAccountAlert, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                Task {
                    try await viewModel.deleteAccount()
                }
            }
        } message: {
            Text("Are you sure that you want to remove your account permanently?")
        }
        
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
        .environmentObject(AuthViewModel())
    }
}
