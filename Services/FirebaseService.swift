//
//  FirebaseService.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import Foundation
import Combine
import Firebase

final class FirebaseService {
    @Published var userSession: FirebaseAuth.User?
    @Published var user: User? = nil
    
    let userCollection = Firestore.firestore().collection("users")
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func create(collectionPath: String, userId: String, documentData: [String:Any]) async throws {
        let document = userDocument(userId: userId).collection(collectionPath).document()
        try await document.setData(documentData, merge: false)
    }
    
    func update<T: Identifiable>(collectionPath: String, uid: String, typeToUpdate: T, typeDictionary: [String:Any]) {
        userDocument(userId: uid).collection(collectionPath).document("\(typeToUpdate.id)").updateData(typeDictionary)
    }
}
