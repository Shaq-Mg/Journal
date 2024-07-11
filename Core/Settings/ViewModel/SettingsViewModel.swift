//
//  SettingsViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signOut() throws {
        try authService.signOut()
    }
    
    func delete() async throws {
        try await authService.deleteAccount()
    }
    
    func resetPassword() async throws {
        
    }
    
    func updatePassword(password: String) async throws {
        try await authService.updatePassword(password: password)
    }
    
    func updateEmail(email: String) async throws {
        try await authService.updateEmail(email: email)
    }
}
