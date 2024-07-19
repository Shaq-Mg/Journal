//
//  SignUpView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        InputView(text: $viewModel.name, title: "Name", placeholder: "Name")
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com")
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", isSecureField: true)
                        
                        InputView(text: $viewModel.confirmPassword, title: "Confirm Password", placeholder: "Confirm password", isSecureField: true)
                        
                    }
                    RegistrationButton(title: "Create account") {
                        Task {
                            do {
                                if formIsValid {
                                    try await viewModel.signUp()
                                    showSignInView = false
                                    viewModel.loginStatusMessage = "Successfully created user: \(viewModel.authService.uid)"
                                }
                            } catch {
                                print("Failed to login user \(error)")
                                viewModel.loginStatusMessage = "Failed to login user: \(error)"
                            }
                        }
                    }
                    
                    Button("Already have a account? Login") {
                        dismiss()
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
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpView(showSignInView: .constant(false))
        }
        .environmentObject(AuthViewModel(authService: dev.authService))
    }
}
