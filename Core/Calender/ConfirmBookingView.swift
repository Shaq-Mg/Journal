//
//  ConfirmBookingView.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import SwiftUI

struct ConfirmBookingView: View {
    @EnvironmentObject var vm: AppointmentViewModel
    @Environment(\.dismiss) private var dismiss
    var currentDate: Date
    
    var body: some View {
        VStack {
            MenuHeaderView(isPressed: { }, title: "Booking confirmed")
            NavigationStack {
                VStack {
                    Text(currentDate.fullMonthDayYearFormat())
                    Spacer()
                    VStack(alignment: .leading, spacing: 30) {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "person.fill")
                            Text(vm.name)
                        }
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "book.fill")
                            Text(vm.service?.title ?? "-")
                        }
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "clock.fill")
                            Text(currentDate.dayViewDateFormat())
                        }
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "minus.circle.fill")
                            Button("Cancel") {

                            }
                        }
                        .foregroundStyle(.indigo)
                    }
                    .onAppear { vm.fetchAppointments() }
                    .font(.title2)
                    
                    Spacer()
                    Button("Done") {
                        vm.name = ""
                        vm.service = nil
                        dismiss()
                    }
                    .foregroundStyle(.indigo)
                    .font(.system(size: 20, weight: .semibold))
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ConfirmedBookingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ConfirmedBookingView(currentDate: Date())
                .environmentObject(AppointmentViewModel())
        }
    }
}

struct ConfirmBookingView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmBookingView()
    }
}
