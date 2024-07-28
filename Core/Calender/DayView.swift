//
//  DayView.swift
//  Journal
//
//  Created by Shaquille McGregor on 27/07/2024.
//

import SwiftUI

struct DayView: View {
    @EnvironmentObject var vm: ApptViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HeaderView(title: "Day")
            NavigationStack {
                List {
                    Section("Bookings today") {
                        ForEach(vm.appointments) { appointment in
                            ApptRowView(appointment: appointment)
                        }
                    }
                }
                .onAppear { vm.fetchAppointments() }
            }
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DayView()
                .environmentObject(ApptViewModel())
        }
    }
}
