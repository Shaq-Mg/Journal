//
//  AuthenticationViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var loginStatusMessage = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchCurrentUser()
        }
    }
    
    func clearLoginInformation() {
        email = ""
        password = ""
        confirmPassword = ""
        loginStatusMessage = ""
    }
    
    func fetchCurrentUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
    }
    
    func signUp(withEmail email: String, name: String, password: String, confirmPassword: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut() // signs out user on backend
            self.userSession = nil // wipes out user session and takes us back to login screen
            self.currentUser = nil // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            return // handle error
        }
        try await user.delete()
    }
}
