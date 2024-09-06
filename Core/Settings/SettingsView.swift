//
//  SettingsView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var showSignOutAlert = false
    @State private var showDeleteAccountAlert = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Settings")
            List {
                Section("Profile information") {
                    SettingsSectionView(title: "Update password", imageName: "key.fill", isPressed: { })
                    SettingsSectionView(title: "Update email", imageName: "envelope.fill", isPressed: { })
                }
                
                Section("More") {
                    SettingsSectionView(title: "Appearance", imageName: "moon.fill") { }
                    SettingsSectionView(title: "Notifications", imageName: "bell.badge.fill") { }
                    SettingsSectionView(title: "Contact us", imageName: "message.fill") { }
                    SettingsSectionView(title: "Privacy policy", imageName: "shield.righthalf.filled") { }
                }
                
                Section("Account") {
                    SettingsSectionView(title: "Subscriptions", imageName: "iphone") { }
                    SettingsSectionView(title: "Delete account", imageName: "minus.circle", isPressed: { showDeleteAccountAlert.toggle() })
                    SettingsSectionView(title: "Sign out", imageName: "lock.fill", isPressed: { showSignOutAlert.toggle() })
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        .confirmationDialog("Sign out", isPresented: $showSignOutAlert, titleVisibility: .visible) {
            Button("Yes", role: .destructive) {
                DispatchQueue.main.async {
                    viewModel.signOut()
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

#Preview {
    NavigationStack {
        SettingsView(showSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
    }
}
