//
//  Service.swift
//  Journal
//
//  Created by Shaquille McGregor on 14/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Service: Identifiable, Codable {
    @DocumentID var id: String?
    let title: String
    let price: Double
    let duration: Double
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case price
        case duration
    }
}
