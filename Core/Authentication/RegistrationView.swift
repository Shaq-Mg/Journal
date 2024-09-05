//
//  RegistrationView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/09/2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            InputView(text: $authViewModel.confirmPassword, placeholder: "Confirm password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Create account") {
                Task {
                    try await authViewModel.createUser(withEmail: authViewModel.email, password: authViewModel.password)
                }
            }
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .disabled(!formIsValid)
            .background(Color.accentColor.opacity(formIsValid ? 1.0 : 0.5))
            .cornerRadius(8)
            .padding(.vertical)
            
            Button("Already have a existing account? login") {
                dismiss()
            }
            .foregroundStyle(.black)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create account")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            authViewModel.clearLoginInformation()
        }
    }
}

#Preview {
    NavigationStack {
        RegistrationView()
            .environmentObject(AuthViewModel())
    }
}
