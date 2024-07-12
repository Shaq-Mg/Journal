//
//  Hours.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Hours: Codable {
    @DocumentID var id: String?
    let day: Int
    let start: Int
    let end: Int
    
    enum codingKeys: String, CodingKey {
        case day, start, end
    }
}
