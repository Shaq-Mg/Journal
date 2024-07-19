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
        loginStatusMessage = ""
    }
    
    func fetchCurrentUser() async throws {
        try await authService.fetchUser()
    }
    
    func signUp() async throws {
        try await authService.createAccount(email: email, password: password, name: name)
    }
    
    func signIn() async throws {
        try await authService.signInUser(email: email, password: password)
    }
}
