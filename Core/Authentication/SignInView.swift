//
//  SignInView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/09/2024.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            InputView(text: $authViewModel.email, placeholder: "Email")
            InputView(text: $authViewModel.password, placeholder: "Password", isSecureField: true)
            
            Text(authViewModel.errorMessage)
                .foregroundStyle(.red)
                .padding()
            
            Button("Sign In") {
                Task {
                    try await authViewModel.signIn(withEmail: authViewModel.email, password: authViewModel.password)
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
            
            NavigationLink("Dont have a existing account? sign up") {
                RegistrationView()
                    .environmentObject(authViewModel)
            }
            .foregroundStyle(.black)
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            authViewModel.clearLoginInformation()
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
            .environmentObject(AuthViewModel())
    }
}
