//
//  Profile.swift
//  Journal
//
//  Created by Shaquille McGregor on 10/07/2024.
//

import Foundation

struct Profile: Codable {
    let name: String
    let email: String
    let photoUrl: String
    var isPremium: Bool
    
    init(name: String? = nil, email: String? = nil, photoUrl: String? = nil) {
        self.name = name ?? "n/a"
        self.email = email ?? "n/a"
        self.photoUrl = photoUrl ?? "n/a"
        self.isPremium = false
    }
}
