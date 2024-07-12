//
//  AuthService.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

final class AuthService {
    @Published var profile = Profile()
    @Published var authState: AuthState = .nonAuthenticated
    @Published var uid = ""
    
    init() {
        setupAuthListener()
    }
    
    private func setupAuthListener() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.authState = user == nil ? .nonAuthenticated : .authenticated
            guard let user = user else { return }
            self.uid = user.uid
        }
    }
    
    func createAccount(email: String, password: String, name: String) async throws {
        guard name != "" else { return }
        try await Auth.auth().createUser(withEmail: email, password: password)
        guard uid != "" else { return }
        try createNewUser(name: name, email: email)
    }
    
    private func createNewUser(name: String, email: String) throws {
        let reference = Firestore.firestore().collection("users").document(uid)
        let profile = Profile(name: name, email: email)
        try reference.setData(from: profile)
    }
    
    func signInUser(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func fetchUser() async throws {
        guard uid != "" else { return }
        let reference = Firestore.firestore().collection("users").document(uid)
        profile = try await reference.getDocument(as: Profile.self)
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            return // handle error
        }
        try await user.delete()
    }
    
    func updatePassword(password: String) async throws {
        guard let user = Auth.auth().currentUser else {
            return // hnadle error
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws {
        //        guard let user = Auth.auth().currentUser else {
        //            return // hnadle error
        //        }
        //        try await user.updateEmail(to: email)
    }
    
    func restPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePremiumStatus(userId: String, isPremium: Bool) async throws {
        let data: [String:Any] = [ Profile.CodingKeys.isPremium.rawValue : isPremium ]
        try await Firestore.firestore().document(userId).updateData(data)
    }
}
