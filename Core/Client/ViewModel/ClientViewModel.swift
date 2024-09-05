//
//  ClientViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import Firebase

@MainActor
final class ClientViewModel: ObservableObject {
    @Published var clients = [Client]()
    @Published var searchText = ""
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var nickname = ""
    @Published var isFavourite = false
    @Published var client: Client? = nil
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    let firebaseService: FirebaseService
    let db = Firestore.firestore()
    
    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
        self.fetchClients()
    }
    
    private func clearInformation() {
        name = ""
        phoneNumber = ""
        nickname = ""
        isFavourite = false
    }
    
    func fetchClients() {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userDocument(userId: uid).collection("clients").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.clients = snapshot.documents.map({ doc in
                            return Client(id: doc.documentID, name: doc[Client.CodingKeys.name.rawValue] as? String ?? "n/a", phoneNumber: doc[Client.CodingKeys.phoneNumber.rawValue] as? String ?? "n/a", nickname: doc[Client.CodingKeys.nickname.rawValue] as? String ?? "n/a", isFavourite: doc[Client.CodingKeys.isFavourite.rawValue] as? Bool ?? false)
                        })
                    }
                }
            } else {
                // handle error here
            }
        }
    }
    
    func create(name: String, phoneNumber: String, nickname: String?, isFavourite: Bool) {
        guard let uid = firebaseService.userSession?.uid else { return }
        Task {
            try await firebaseService.create(collectionPath: "clients", userId: uid, documentData: [Client.CodingKeys.name.rawValue: name, Client.CodingKeys.phoneNumber.rawValue: phoneNumber, Client.CodingKeys.nickname.rawValue: nickname ?? "n/a", Client.CodingKeys.isFavourite.rawValue: isFavourite])
        }
        self.clearInformation()
    }
    
    func update(clientToUpdate: Client) {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userCollection.document(uid).collection("clients").document(clientToUpdate.id ?? "").setData(["name": clientToUpdate.name, "phone_number": clientToUpdate.phoneNumber,"nickname": clientToUpdate.nickname ?? "n/a", "is_favourite": clientToUpdate.isFavourite], merge: true)
    }
    
    func delete(clientToDelete: Client) {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userDocument(userId: uid).collection("clients").document(clientToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.clients.removeAll { client in
                        return client.id == clientToDelete.id
                    }
                }
                self.fetchClients()
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
}
