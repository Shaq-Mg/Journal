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
    let time: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case service
        case time
    }
    
    static let preview = Appointment(name: "Kobe", service: "Haircut", time: Date())
}
