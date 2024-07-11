//
//  AuthenticationViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var loginStatusMessage = ""
    
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    func fetchCurrentUser() async throws {
        try await authService.fetchUser()
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            print("No email or password found.") // handle error
            return
        }
        try await authService.createAccount(email: email, password: password, name: name)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("Incorrect login information") // handle error
            return
        }
        try await authService.signInUser(email: email, password: password)
    }
}
