//
//  CalenderViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

import Firebase
import FirebaseFirestore

final class CalenderViewModel: ObservableObject {
    @Published var availableDates = [Date]()
    @Published var appointments = [Appointment]()
    @Published var hours = [Hours]()
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var showConfirmedAppt = false
    @Published var bookApptCover = false
    @Published var currentDate: Date?
    @Published var selectedDate = Date()
    
    let hoursCollection = Firestore.firestore().collection("hours")
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
        Task {
            do {
                let dates = try await self.availableAppointments()
                await MainActor.run {
                    availableDates = dates
                    availableDays = Set(availableDates.map({ $0.monthDayYearFormat() }))
                }
            } catch {
                // handle error here
            }
        }
    }
    
    func fetchHours() async throws -> [Hours] {
        let response: [Hours] = hoursCollection.addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.hours = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Hours.self)
                }
            }
        } as? [Hours] ?? []
       return response
    }
    
    private func availableAppointments() async throws -> [Date] {
        let uid = service.userSession?.uid ?? ""
        let appts: [Appointment] = service.userDocument(userId: uid).collection("appointments").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.appointments = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Appointment.self)
                }
            }
        } as? [Appointment] ?? []
        return try await generateAppointmentTimes(from: appts)
    }
    
    private func generateAppointmentTimes(from appts: [Appointment]) async throws -> [Date] {
        let takenAppts: Set<Date> = Set(appts.map({ $0.date }))
        let hours = try await fetchHours()
        let calender = Calendar.current
        let currentWeekDay = calender.component(.weekday, from: Date()) - 2
        
        var timeSlots = [Date]()
        for weekOffset in 0...4 {
            let daysOffset = weekOffset * 7
            
            for hour in hours {
                if hour.start != 0 && hour.end != 0 {
                    var currentDate = calender.date(from: DateComponents(year: calender.component(.year, from: Date()), month: calender.component(.month, from: Date()), day: calender.component(.day, from: Date()) + (hour.day - currentWeekDay), hour: hour.start))
                    
                    while let nextDate = calender.date(byAdding: .minute, value: 15, to: currentDate ?? Date()),
                          calender.component(.hour, from: nextDate) <= hour.end {
                        
                        if !takenAppts.contains(currentDate ?? Date()) && currentDate ?? Date() > Date() && calender.component(.hour, from: currentDate ?? Date()) != hour.end {
                            timeSlots.append(currentDate ?? Date())
                        }
                        currentDate = nextDate
                    }
                }
            }
        }
        return timeSlots
    }
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let db = Firestore.firestore()
    
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
    
    func bookAppointment(name: String, date: Date) async throws {
        
    }
    
    func fetchAppointments() {
        
    }
}
