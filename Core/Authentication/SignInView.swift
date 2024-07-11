//
//  SignInView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Color.secondary.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com")
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
                    }
                    RegistrationButton(title: "Sign In") {
                        Task {
                            do {
                                try await viewModel.signIn()
                                viewModel.showSignInView = false
                                viewModel.loginStatusMessage = "Successfully logged in user: \(viewModel.authService.uid)"
                            } catch {
                                print("Failed to login user \(error)")
                                viewModel.loginStatusMessage = "Failed to login user: \(error)"
                            }
                        }
                    }
                    
                    NavigationLink("Dont have a account? Sign up") {
                        SignUpView()
                    }
                    .font(.callout)
                    .foregroundStyle(.black)
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        let authService = AuthService()
        NavigationStack {
            SignInView()
        }
        .environmentObject(AuthViewModel(authService: authService))
    }
}
