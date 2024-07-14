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
    
    func fetchCollection<T: Codable>(from collectionPath: String, as type: T.Type) async throws -> [T] {
        let db = Firestore.firestore()
        
        let snapshot = try await db.collection(collectionPath).getDocuments()
        
        let objects = try snapshot.documents.compactMap { document in
            try document.data(as: T.self)
        }
        return objects
    }
    
    func createCollection(collectionPath: String, documentData: [String:Any]) async throws {
        let db = Firestore.firestore()
        
        let document = db.collection(collectionPath).document()
        try await document.setData(documentData, merge: false)
    }

    func update<T: Identifiable>(collectionPath: String, typeToUpdate: T, typeDictionary: [String:Any]) {
        let db = Firestore.firestore()
        db.collection("appointments").document("\(typeToUpdate.id)").updateData(typeDictionary)
    }
}
