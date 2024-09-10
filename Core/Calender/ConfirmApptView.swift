//
//  ConfirmApptView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct ConfirmApptView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @EnvironmentObject private var serviceVM: ServiceViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var bookingConfirmed = false
    
    var body: some View {
        ZStack {
            if bookingConfirmed {
                VStack(spacing: 44) {
                    Text("Appointment confirmed")
                        .font(.system(size: 25, weight: .bold))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        ConfirmApptHeaderView(imageName: "clock.fill", text: calenderVM.selectedDate.dayViewDateFormat())
                        ConfirmApptHeaderView(imageName: "person.fill", text: calenderVM.name)
                        ConfirmApptHeaderView(imageName: "pencil", text: calenderVM.title)
                    }
                }
                .transition(.move(edge: .bottom))
                .background(.white)
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color(.systemGray))
                        }
                    }
                }
            } else {
                BookServiceView(bookingConfirmed: $bookingConfirmed, currentDate: calenderVM.selectedDate)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ConfirmApptView()
            .environmentObject(CalenderViewModel(database: FirebaseService()))
            .environmentObject(ServiceViewModel(firebaseService: FirebaseService()))
    }
}
