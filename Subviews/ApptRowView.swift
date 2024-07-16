//
//  ApptRowView.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import SwiftUI

struct ApptRowView: View {
    let appointment: Appointment
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "pencil")
                .padding(12)
                .background(.secondary.opacity(0.2))
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.name)
                Text(appointment.service.title)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            Text("\(appointment.date.dayViewDateFormat())")
                .font(.system(size: 10, weight: .semibold))
        }
        .font(.system(size: 20, weight: .semibold))
    }
}

struct ApptRowView_Previews: PreviewProvider {
    static var previews: some View {
        ApptRowView(appointment: dev.appointment)
    }
}
