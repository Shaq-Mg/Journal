//
//  HomeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            Button("Sign out") {
                authViewModel.signOut()
            }
            .navigationTitle(authViewModel.currentUser?.email ?? "n/a")
            .task { await authViewModel.fetchUser() }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
