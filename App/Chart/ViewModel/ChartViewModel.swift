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
    
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
    }
    
    func bookAppointment(name: String, date: Date) async throws {
        
    }
    
    func fetchAppointments() {
        
    }
}


