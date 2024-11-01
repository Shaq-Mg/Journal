//
//  ChartViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class ChartViewModel: ObservableObject {
    @Published var appointments = [Appointment]()
    @Published var upcomingAppointments = [Appointment]()
    
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
    }
    
    func bookAppointment(name: String, date: Date) async throws {
        
    }
    
    func fetchAppointments() {
        
    }
    
    func fetchUpcomingAppts(from date: Date) {
        let dateTimestamp = Timestamp(date: date)
        guard let uid = service.userSession?.uid else { return }
        
        service.userDocument(userId: uid).collection("appointments")
            .whereField("time", isGreaterThanOrEqualTo: dateTimestamp)
            .order(by: "time", descending: false)
            .limit(to: 5)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error)")
                } else {
                    self.upcomingAppointments = querySnapshot?.documents.compactMap { document -> Appointment? in
                        try? document.data(as: Appointment.self)
                    } ?? []
                }
            }
    }
}


