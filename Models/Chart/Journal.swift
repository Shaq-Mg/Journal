//
//  Journal.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import Foundation
import FirebaseFirestore

struct Journal: Identifiable, Hashable {
    @DocumentID var id: String?
    let booking: Int
    let date: Date
    
    static func previousSevenDays() -> [Journal] {
        var data: [Journal] = []
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<7 {
            if let previousDate = calendar.date(byAdding: .day, value: -i, to: today) {
                let value = Int.random(in: 1...20) // Replace with actual data if needed
                data.append(Journal(booking: value, date: previousDate))
            }
        }
        
        return data.reversed() // Reverse to get the oldest date first
    }
    
    static func currentWeek() -> [Journal] {
        var data: [Journal] = []
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<7 {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: today) {
                let value = Int.random(in: 1...20) // Replace with actual data if needed
                data.append(Journal(booking: value, date: nextDate))
            }
        }
        
        return data
    }
}
