//
//  CalenderViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class CalenderViewModel: ObservableObject {
    
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var currentDate: Date?
    @Published var selectedDate = Date()
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let hoursCollection = Firestore.firestore().collection("hours")
    private let db = Firestore.firestore()
    private let database: FirebaseService
    
    init(database: FirebaseService) {
        self.database = database
    }
    
    func fetchDates() -> [Calender] {
        let calender = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({ Calender(day: calender.component(.day, from: $0), date: $0) })
        
        let firstDayOfWeek = calender.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(Calender(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calender = Calendar.current
        
        let month = calender.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
    
    // Method to check if the previous month should be disabled
    func isPreviousMonthDisabled() -> Bool {
        let current = Calendar.current.dateComponents([.month, .year], from: Date())
        let selected = Calendar.current.dateComponents([.month, .year], from: selectedDate)
        
        // Disable if the selected month and year are equal to or before the current month and year
        return selected.year! <= current.year! && selected.month! <= current.month!
    }
}
