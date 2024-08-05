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
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.opacity(0.8).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack(spacing: 10) {
                        InputView(text: $viewModel.name, title: "Name", placeholder: "Name", action: { viewModel.name = "" })
                        
                        InputView(text: $viewModel.email, title: "Email", placeholder: "User@hotmail.com", action: { viewModel.email = "" })
                        
                        InputView(text: $viewModel.password, title: "Password", placeholder: "password", action: { viewModel.password = "" }, isSecureField: true)
                        
                        InputView(text: $viewModel.confirmPassword, title: "Confirm Password", placeholder: "Confirm password", action: { viewModel.confirmPassword = "" }, isSecureField: true)
                        
                    }
                    RegistrationButton(title: "Create account") {
                        Task {
                            do {
                                if formIsValid {
                                    try await viewModel.signUp(withEmail: viewModel.email, name: viewModel.name, password: viewModel.password, confirmPassword: viewModel.confirmPassword)
                                    
                                    viewModel.loginStatusMessage = "Successfully created user: \(viewModel.userSession?.uid)"
                                }
                            } catch {
                                print("Failed to login user \(error)")
                                viewModel.loginStatusMessage = "Failed to login user: \(error)"
                            }
                        }
                    }
                    .disabled(!formIsValid)
                    
                    Button("Already have a account? Login") {
                        dismiss()
                    }
                    .font(.callout)
                    .foregroundStyle(.black)
                    Text(viewModel.loginStatusMessage)
                        .padding(!viewModel.loginStatusMessage.isEmpty ? 8 : 0)
                        .background(RoundedRectangle(cornerRadius: 5).foregroundStyle(.red))
                        .shadow(radius: 2)
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
            SignUpView()
        }
        .environmentObject(AuthViewModel())
    }
}
