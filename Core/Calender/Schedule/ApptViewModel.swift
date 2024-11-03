//
//  ApptViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/11/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class ApptViewModel: ObservableObject {
    @Published var availableMorningTimes = [Date]()
    @Published var availableAftenoonTimes = [Date]()
    @Published var availableEveningTimes = [Date]()
    
    @Published var appointments: [Appointment] = []
    @Published var selectedTime: Date? = nil
    @Published var selectedDate = Date()
    @Published var services = [Service]()
    @Published var hours = [Hours]()
    
    @Published var name = ""
    @Published var title = ""
    
    @Published var appointment: Appointment? = nil
    @Published var service: Service? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let database: FirebaseService
    
    init(database: FirebaseService) {
        self.database = database
        
        $selectedDate
            .sink { [weak self] newDate in
                self?.fetchAppointments(for: newDate)
            }
            .store(in: &cancellables)
    }
    
    // Fetch appointments for a specific date
    func fetchAppointments(for date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Start and end of the selected day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        database.userDocument(userId: uid).collection("appointments")
            .whereField("date", isGreaterThanOrEqualTo: startOfDay)
            .whereField("date", isLessThan: endOfDay)
            .order(by: "date")
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Error fetching appointments: \(error)")
                    return
                }
                
                self?.appointments = snapshot?.documents.compactMap { document in
                    try? document.data(as: Appointment.self)
                } ?? []
            }
    }
    
    // Add a new appointment
    func addAppointment(name: String, service: String, date: Date) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let newAppointment = Appointment(name: name, service: service, time: date)
        
        do {
            _ = try database.userDocument(userId: uid).collection("appointments").addDocument(from: newAppointment)
            fetchAppointments(for: selectedDate) // Refresh after adding
        } catch let error {
            print("Error adding appointment: \(error)")
        }
    }
    
    func updateAppt(apptToUpdate: Appointment) {
        guard let uid = database.userSession?.uid else { return }
        database.userCollection.document(uid).collection("appointments").document(apptToUpdate.id ?? "").setData(["name": apptToUpdate.name, "title": apptToUpdate.service, "time": apptToUpdate.time], merge: true)
    }
    
    func deleteAppt(apptToDelete: Appointment) {
        guard let uid = database.userSession?.uid else { return }
        database.userDocument(userId: uid).collection("appointments").document(apptToDelete.id ?? "").delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.appointments.removeAll { appt in
                        return appt.id == apptToDelete.id
                    }
                }
                self.fetchAppointments(for: self.selectedDate)
            } else {
                // handle error here
                print("Failed to delete client to firestore")
            }
        }
    }
}

extension ApptViewModel {
    
    // Function to handle selecting a time slot
    func selectMorningTimeSlot(_ time: Date) {
        // Remove the selected time from the array
        availableMorningTimes.removeAll { $0 == time }
    }
    
    func selectAfternoonTimeSlot(_ time: Date) {
        // Remove the selected time from the array
        availableAftenoonTimes.removeAll { $0 == time }
    }
    
    func selectEveningTimeSlot(_ time: Date) {
        // Remove the selected time from the array
        availableEveningTimes.removeAll { $0 == time }
    }
    
    
    // Helper function to format times
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // e.g. 8:00 AM
        return formatter.string(from: date)
    }
    
    func generateMorningTimes() -> [Date] {
        let times = database.generateAppointmentTimes(startHour: 6, startMinute: 0, endHour: 11, endMinute: 45)
        self.availableMorningTimes = times
        return availableMorningTimes
    }
    
    func generateAfternoonTimes() -> [Date] {
        let times = database.generateAppointmentTimes(startHour: 12, startMinute: 0, endHour: 16, endMinute: 45)
        self.availableAftenoonTimes = times
        return availableAftenoonTimes
    }
    
    func generateEveningTimes() -> [Date] {
        let times = database.generateAppointmentTimes(startHour: 17, startMinute: 0, endHour: 22, endMinute: 0)
        self.availableEveningTimes = times
        return availableEveningTimes
    }
    
    func fetchServices() {
        guard let uid = database.userSession?.uid else { return }
        database.userDocument(userId: uid).collection("services").getDocuments { snapshot, error in
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
}
