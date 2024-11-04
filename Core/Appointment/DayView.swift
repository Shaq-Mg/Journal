//
//  DayView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var apptVM: ApptViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showSideMenu: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, onDismiss: true, title: currentDate.dayOfTheWeek())
            List {
                Section("Bookings today") {
                    ForEach(apptVM.appointments) { appointment in
                        ZStack {
                            NavigationLink(destination: ApptDetailView(appt: appointment)) {
                                EmptyView()
                            }
                            .opacity(0)
                            ApptCellView(appointment: appointment)
                        }
                    }
                }
            }
            .onAppear {
                apptVM.selectedDate = currentDate
                apptVM.fetchAppointments(for: currentDate)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        DayView(showSideMenu: .constant(false), currentDate: Date())
            .environmentObject(ApptViewModel(database: FirebaseService()))
    }
}
