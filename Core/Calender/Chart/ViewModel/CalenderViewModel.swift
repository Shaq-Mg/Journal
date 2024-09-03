//
//  CalenderViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class CalenderViewModel: ObservableObject {
    @Published var availableDates = [Date]()
    @Published var appointments = [Appointment]()
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var showConfirmedAppt = false
    @Published var bookApptCover = false
    @Published var currentDate: Date?
    @Published var selectedDate = Date()
    
    let service: FirebaseService
    let hoursCollection = Firestore.firestore().collection("hours")
    
    init(service: FirebaseService) {
        self.service = service
        }
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let db = Firestore.firestore()
    
    
    func fetchSelectedMonth() -> Date {
        let calender = Calendar.current
        
        let month = calender.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
    
    func bookAppointment(name: String, date: Date) async throws {
        
    }
    
    func fetchAppointments() {
        
    }
}
