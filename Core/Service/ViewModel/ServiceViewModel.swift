//
//  ServiceViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 22/07/2024.
//

import Foundation
import Firebase

final class ServiceViewModel: ObservableObject {
    @Published var services = [Service]()
    @Published var searchText = ""
    @Published var title = ""
    @Published var price = ""
    @Published var duration = ""
    
    var filteredServices: [Service] {
        guard !searchText.isEmpty else { return services }
        return services.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
    }
    
    func fetchServices() {

    }
    
    func saveService(title: String, price: String, duration: String) {

    }
    
    func deleteService(serviceToDelete: Service) {
        Firestore.firestore().collection("services").document(serviceToDelete.id ?? "").delete { error in
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
