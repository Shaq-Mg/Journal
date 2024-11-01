//
//  DayView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var vm: CalenderViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showSideMenu: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, onDismiss: true, title: currentDate.dayOfTheWeek())
            List {
                Section("Bookings today") {
                    ForEach(vm.appointments) { appointment in
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
            .onAppear { vm.fetchAppts() }
        .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        DayView(showSideMenu: .constant(false), currentDate: Date())
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}
