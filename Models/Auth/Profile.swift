//
//  Profile.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Profile: Codable {
    @DocumentID var id: String?
    let name: String
    let email: String
    let photoUrl: String
    var isPremium: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case photoUrl = "photo_url"
        case isPremium = "is_premium"
    }
    
    init(name: String? = nil, email: String? = nil, photoUrl: String? = nil) {
        self.name = name ?? "n/a"
        self.email = email ?? "n/a"
        self.photoUrl = photoUrl ?? "n/a"
        self.isPremium = false
    }
}
