//
//  AuthUser.swift
//  Journal
//
//  Created by Shaquille McGregor on 31/08/2024.
//

import Foundation
import Firebase

struct AuthUser: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    var isPremium: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case isPremium = "is_premium"
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
