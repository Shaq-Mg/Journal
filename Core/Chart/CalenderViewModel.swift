//
//  CalenderViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class CalenderViewModel: ObservableObject {
    @Published var availableDates = [Date]()
    @Published var appointments = [Appointment]()
    @Published var hours = [Hours]()
    @Published var availableDays: Set<String> = []
    @Published var selectedMonth = 0
    @Published var currentDate: Date?
    @Published var selectedDate = Date()
    @Published var selectedTime = Date()
    
    @Published var services = [Service]()
    
    @Published var name = ""
    @Published var title = ""
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let hoursCollection = Firestore.firestore().collection("hours")
    let db = Firestore.firestore()
    let service: FirebaseService
    
    init(service: FirebaseService) {
        self.service = service
    }
    
    func generateMorningTimes() -> [Date] {
        service.generateAppointmentTimes(startHour: 6, startMinute: 0, endHour: 11, endMinute: 45)
    }
    
    func generateAfternoonTimes() -> [Date] {
        service.generateAppointmentTimes(startHour: 12, startMinute: 0, endHour: 16, endMinute: 45)
    }
    
    func generateEveningTimes() -> [Date] {
        service.generateAppointmentTimes(startHour: 17, startMinute: 0, endHour: 22, endMinute: 0)
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
    
    func bookAppointment(name: String, title: String, time: Date) {
        guard let uid = service.userSession?.uid else { return }
        
        Task {
            try await service.create(collectionPath: "appointments", userId: uid, documentData: [Appointment.CodingKeys.name.rawValue: name, Appointment.CodingKeys.service.rawValue: title, Appointment.CodingKeys.time.rawValue: time])
        }
    }
    
    func updateAppt(apptToUpdate: Appointment) {
        guard let uid = service.userSession?.uid else { return }
        service.userCollection.document(uid).collection("appointments").document(apptToUpdate.id ?? "").setData(["name": apptToUpdate.name, "title": apptToUpdate.service, "time": apptToUpdate.time], merge: true)
    }
    
    func deleteAppt(apptToDelete: Appointment) {
        guard let uid = service.userSession?.uid else { return }
        service.userDocument(userId: uid).collection("appointments").document(apptToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.appointments.removeAll { appt in
                        return appt.id == apptToDelete.id
                    }
                }
                self.fetchAppts()
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
    
    func fetchServices() {
        guard let uid = service.userSession?.uid else { return }
        service.userDocument(userId: uid).collection("services").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.services = snapshot.documents.map({ doc in
                            return Service(id: doc.documentID, title: doc[Service.CodingKeys.title.rawValue] as? String ?? "n/a", price: doc[Service.CodingKeys.price.rawValue] as? String ?? "", duration: doc[Service.CodingKeys.duration.rawValue] as? String ?? "")
                        })
                    }
                }
            } else {
                // handle error here
            }
        }
    }
    
    func fetchAppts() {
        guard let uid = service.userSession?.uid else { return }
        service.userDocument(userId: uid).collection("appointments").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        self.appointments = snapshot.documents.map({ doc in
                            return Appointment(name: doc[Appointment.CodingKeys.name.rawValue] as? String ?? "-", service: doc[Appointment.CodingKeys.service.rawValue] as? String ?? "-", time: doc[Appointment.CodingKeys.time.rawValue] as? Date ?? Date())
                        })
                    }
                }
            } else {
                // handle error here
            }
        }
    }
    
    // Method to check if the previous month should be disabled
    func isPreviousMonthDisabled() -> Bool {
        let current = Calendar.current.dateComponents([.month, .year], from: Date())
        let selected = Calendar.current.dateComponents([.month, .year], from: selectedDate)
        
        // Disable if the selected month and year are equal to or before the current month and year
        return selected.year! <= current.year! && selected.month! <= current.month!
    }
}
