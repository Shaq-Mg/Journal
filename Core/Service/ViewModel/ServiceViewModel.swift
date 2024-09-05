//
//  ServiceViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import Firebase

final class ServiceViewModel: ObservableObject {
    @Published var services = [Service]()
    @Published var service: Service? = nil
    @Published var searchText = ""
    @Published var title = ""
    @Published var price = ""
    @Published var duration = ""
    
    var filteredServices: [Service] {
        guard !searchText.isEmpty else { return services }
        return services.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
    }
    
    let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
        self.fetchServices()
    }
    
    private func clearServiceInformation() {
        searchText = ""
        title = ""
        price = ""
        duration = ""
    }
    
    func fetchServices() {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userDocument(userId: uid).collection("services").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.services = snapshot.documents.map({ doc in
                            return Service(id: doc.documentID, title: doc[Service.CodingKeys.title.rawValue] as? String ?? "n/a", price: doc[Service.CodingKeys.price.rawValue] as? String ?? "", duration: doc[Service.CodingKeys.duration.rawValue] as? String ?? "")
                        })
                    }
                }
            } else {
                // handle error here
            }
        }
    }
    
    func saveService(title: String, price: String, duration: String) {
        guard let uid = firebaseService.userSession?.uid else { return }
        Task {
            try await firebaseService.create(collectionPath: "services", userId: uid, documentData: [Service.CodingKeys.title.rawValue: title, Service.CodingKeys.price.rawValue: price, Service.CodingKeys.duration.rawValue: duration])
        }
        self.clearServiceInformation()
    }
    
    func updateService(serviceToUpdate: Service) {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userCollection.document(uid).collection("services").document(serviceToUpdate.id ?? "").setData([Service.CodingKeys.title.rawValue: serviceToUpdate.title, Service.CodingKeys.price.rawValue: serviceToUpdate.price, Service.CodingKeys.duration.rawValue: serviceToUpdate.duration,], merge: true)
    }
    
    func deleteService(serviceToDelete: Service) {
        guard let uid = firebaseService.userSession?.uid else { return }
        firebaseService.userCollection.document(uid).collection("services").document(serviceToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.services.removeAll { service in
                        return service.id == serviceToDelete.id
                    }
                }
            }
        }
    }
}
