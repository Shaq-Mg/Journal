//
//  SignInView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com", action: { viewModel.email = "" })
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", action: { viewModel.password = "" }, isSecureField: true)
                    }
                    RegistrationButton(title: "Sign In") {
                        Task {
                            do {
                                if formIsValid {
                                    try await viewModel.signIn()
                                    showSignInView = false
                                    viewModel.loginStatusMessage = "Successfully logged in user: \(viewModel.authService.uid)"
                                }
                            } catch {
                                print("Failed to login user \(error)")
                                viewModel.loginStatusMessage = "Failed to login user: \(error)"
                            }
                        }
                    }
                    .disabled(!formIsValid)
                    
                    NavigationLink("Dont have a account? Sign up") {
                        SignUpView(showSignInView: $showSignInView)
                    }
                    .font(.callout)
                    .foregroundStyle(.black)
                    Text(viewModel.loginStatusMessage)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.red))
                }
                .padding(.horizontal)
                .onAppear { viewModel.clearLoginInformation() }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInView(showSignInView: .constant(true))
        }
        .environmentObject(AuthViewModel(authService: dev.authService))
    }
}
