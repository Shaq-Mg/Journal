//
//  AuthenticationViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 31/08/2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: AuthUser?
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
        errorMessage = ""
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = AuthUser(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            errorMessage = "Failed to created user with error \(error.localizedDescription)"
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            errorMessage = "Failed to login user with error \(error.localizedDescription)"
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: AuthUser.self)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            errorMessage = "Failed to sign out user with error \(error.localizedDescription)"
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            return // handle error
        }
        try await user.delete()
    }
}
