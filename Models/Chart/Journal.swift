//
//  Journal.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Journal: Identifiable, Hashable {
    @DocumentID var id: String?
    let booking: Int
    let date: Date
}
