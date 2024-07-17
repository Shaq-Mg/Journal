//
//  RootView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var showSignInView = true
    var body: some View {
        ZStack {
            HomeView(showSignInView: $showSignInView)
                .environmentObject(viewModel)
        }
        .onAppear {
            Task {
                let authUser = try? await viewModel.fetchCurrentUser()
                self.showSignInView = authUser == nil
            }
        }
        .fullScreenCover(isPresented: $showSignInView) {
            SignInView(showSignInView: $showSignInView)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthService()
        NavigationStack {
            RootView()
        }
        .environmentObject(AuthViewModel(authService: authService))
    }
}
