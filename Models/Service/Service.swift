//
//  Service.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Service: Identifiable, Codable {
    @DocumentID var id: String?
    let title: String
    let price: String
    let duration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case duration
    }
}
