//
//  CalenderViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class CalenderViewModel: ObservableObject {
    @Published var appointments = [Appointment]()
    
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
    }
}
