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
    let duartion: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case duartion
    }
}
