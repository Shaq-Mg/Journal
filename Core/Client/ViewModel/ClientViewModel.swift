//
//  ClientViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import Foundation
import Firebase

final class ClientViewModel: ObservableObject {
    @Published var clients = [Client]()
    @Published var searchText = ""
    @Published var name = ""
    @Published var phoneNumber = ""
    @Published var nickname = ""
    @Published var notes = ""
    @Published var isFavourite = false
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    let firebaseService: FirebaseService
    let db = Firestore.firestore()
    
    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
    }
    
    func fetchClients() {
        Task {
            try await firebaseService.fetchCollection(from: "clients", as: Client.self)
        }
    }
    
    func save(name: String, phoneNumber: String, nickname: String?, isFavourite: Bool) {
        Task {
            try await firebaseService.createCollection(collectionPath: "clients", documentData: [Client.CodingKeys.name.rawValue: name, Client.CodingKeys.phoneNumber.rawValue: phoneNumber, Client.CodingKeys.nickname.rawValue: nickname ?? "n/a", Client.CodingKeys.isFavourite.rawValue: isFavourite])
        }
    }
    
    func update(clientToUpdate: Client) {
        db.collection("clients").document(clientToUpdate.id ?? "").setData(["name": clientToUpdate.name, "phone_number": clientToUpdate.phoneNumber,"nickname": clientToUpdate.nickname ?? "n/a", "is_favourite": clientToUpdate.isFavourite], merge: true)
    }
    
    func delete(clientToDelete: Client) {
        let db = Firestore.firestore()
        db.collection("clients").document(clientToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.clients.removeAll { client in
                        return client.id == clientToDelete.id
                    }
                }
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
}
