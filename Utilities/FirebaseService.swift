//
//  FirebaseService.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine

final class FirebaseService {
    @Published var userSession: FirebaseAuth.User?
    @Published var user: AuthUser? = nil
    
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

extension Query {
    func getDocuments<T>(type as: T.Type) async throws -> [T] where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        return try snapshot.documents.map({ doc in
            try doc.data(as: T.self)
        })
    }
}

