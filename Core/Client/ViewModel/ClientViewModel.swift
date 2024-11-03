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
    
    private var clientListener: ListenerRegistration? = nil
    
    var filteredClients: [Client] {
        guard !searchText.isEmpty else { return clients }
        return clients.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
    }
    
    let firebaseService: FirebaseService
    let db = Firestore.firestore()
    
    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
        self.fetchClientsWithListener()
    }
    
    deinit {
        self.clientListener?.remove()
    }
    
    private func clearInformation() {
        name = ""
        phoneNumber = ""
        nickname = ""
        isFavourite = false
    }
    
    func fetchClientsWithListener() {
        guard let uid = firebaseService.userSession?.uid else { return }
        self.clientListener = firebaseService.userDocument(userId: uid).collection("clients").order(by: Client.CodingKeys.name.rawValue) // Optional: sort by a field
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self?.clients = documents.compactMap({ try? $0.data(as: Client.self) })
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
    
    func deleteClient(at offsets: IndexSet) {
        guard let uid = firebaseService.userSession?.uid else { return }
        offsets.forEach { index in
            let client = clients[index]
            if let clientID = client.id {
                firebaseService.delete(uid: uid, collectionPath: "clients", docToDelete: clientID)
            }
        }
    }
}
