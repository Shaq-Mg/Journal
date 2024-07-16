//
//  Client.swift
//  Journal
//
//  Created by Shaquille McGregor on 14/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Client: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let phoneNumber: String
    let nickname: String?
    let isFavourite: Bool
    
    enum CodingKeys:String, CodingKey {
        case id = "id"
        case name = "name"
        case phoneNumber = "phone_number"
        case nickname = "nickname"
        case isFavourite = "is_favourite"
    }
}
