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
    @Published var profile: Profile? = nil
    
    func create(collectionPath: String, docId: String, documentData: [String:Any]) async throws {
        guard let uid = profile?.id else { return }
        let db = Firestore.firestore()
        
        let document = db.collection("users").document(uid).collection(collectionPath).document(docId)
        try await document.setData(documentData, merge: false)
    }

    func update<T: Identifiable>(collectionPath: String, uid: String, typeToUpdate: T, typeDictionary: [String:Any]) {
        guard let uid = profile?.id else { return }
        let db = Firestore.firestore()
        db.collection("users").document(uid).collection(collectionPath).document("\(typeToUpdate.id)").updateData(typeDictionary)
    }
    
    func delete<T: Identifiable>(collectionPath: String, docId: String, typeToDelete: T) {
        guard let uid = profile?.id else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).collection(collectionPath).document(typeToDelete.id  as? String ?? "")
    }
}
