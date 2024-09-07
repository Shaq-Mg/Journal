//
//  ApptDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct ApptDetailView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @State private var showConfirmation = false
    @Environment(\.dismiss) private var dismiss
    let appt: Appointment
    
    var body: some View {
        List {
            Section("General") {
                SelectDetailView(title: "Name", description: appt.name)
                SelectDetailView(title: "Service", description: appt.service)
                SelectDetailView(title: "Time", description: appt.time.dayViewDateFormat())
            }
            .fontWeight(.semibold)
            Section("Update") {
                Button {
                    showConfirmation = true
                } label: {
                    HStack {
                        Image(systemName: "minus.circle")
                        Text("Delete")
                    }
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                    .padding(.vertical)
                }
            }
        }
        .confirmationDialog("Delete Appointment", isPresented: $showConfirmation) {
            Button("Yes") { calenderVM.deleteAppt(apptToDelete: appt)}
        } message: {
            Text("Are you sure you want to delete this Appointment?")
        }
        .navigationTitle(calenderVM.selectedDate.dayOfTheWeek())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }}

#Preview {
    NavigationStack {
        ApptDetailView(appt: Appointment(name: "Kobe", service: "Haircut", time: Date()))
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}
