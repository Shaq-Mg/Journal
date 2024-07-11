//
//  RootView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    var body: some View {
        ZStack {
            HomeView()
        }
        .fullScreenCover(isPresented: $viewModel.showSignInView) {
            SignInView()
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
