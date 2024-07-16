//
//  Appointment.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Appointment: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let service: Service
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case service = "sevice"
        case date = "date"
    }
}
