//
//  Appointment.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Appointment: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let service: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case service = "sevice"
        case date = "date"
    }
}
