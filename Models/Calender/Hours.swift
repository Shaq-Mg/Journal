//
//  Hours.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Hours: Codable {
    @DocumentID var id: String?
    let day: Int
    let start: Int
    let end: Int
    
    enum codingKeys: String, CodingKey {
        case day, start, end
    }
}
