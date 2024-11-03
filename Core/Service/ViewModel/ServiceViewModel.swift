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
    
    private var serviceListener: ListenerRegistration? = nil
    
    private let firebaseService: FirebaseService
    
    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
        self.fetchServicesWithListener()
    }
    
    deinit {
        self.serviceListener?.remove()
    }
    
    private func clearServiceInformation() {
        searchText = ""
        title = ""
        price = ""
        duration = ""
    }
    
    func fetchServicesWithListener() {
        guard let uid = firebaseService.userSession?.uid else { return }
        self.serviceListener = firebaseService.userDocument(userId: uid).collection("services").order(by: Service.CodingKeys.title.rawValue) // Optional: sort by a field
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                
                self?.services = documents.compactMap({ try? $0.data(as: Service.self) })
            }
    }
    
    func addService(title: String, price: String, duration: String) {
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
    
    func deleteService(at offsets: IndexSet) {
        guard let uid = firebaseService.userSession?.uid else { return }
        offsets.forEach { index in
            let service = services[index]
            if let serviceID = service.id {
                firebaseService.delete(uid: uid, collectionPath: "services", docToDelete: serviceID)
            }
        }
    }
}
