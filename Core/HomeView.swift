//
//  HomeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            Text("Hello, \(viewModel.authService.profile.name)")
        }
        .onAppear {
            Task {
                try await viewModel.fetchCurrentUser()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthService()
        NavigationStack {
            HomeView()
        }
        .environmentObject(AuthViewModel(authService: authService))
    }
}
