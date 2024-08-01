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
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            HeaderView(showSideMenu: $showSideMenu, title: "Settings")
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
            //                    MenuRowView(title: "Appearance", iconName: "moon.fill")
            //                    MenuRowView(title: "Subscriptions", iconName: "iphone")
            //                    MenuRowView(title: "Notifications", iconName: "bell.badge.fill")
            //                    MenuRowView(title: "Contact us", iconName: "message.fill")
            //                    MenuRowView(title: "Privacy policy", iconName: "shield.righthalf.filled")
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
            SettingsView(showSideMenu: .constant(false))
        }
        .environmentObject(AuthViewModel())
    }
}
