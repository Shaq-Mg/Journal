//
//  SelectTimeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct SelectTimeView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @Binding var selectedTime: Date?
    @Binding var showConfirmTimeDate: Bool
    var times: [Date]
    
    var body: some View {
        ForEach(times, id: \.self) { time in
            Button {
                withAnimation {
                    selectedTime = time
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showConfirmTimeDate.toggle()
                    }
                }
            } label: {
                Text(calenderVM.formattedTime(time))
                    .font(.system(size: selectedTime == time ? 22 : 16))
                    .foregroundStyle(selectedTime == time ? Color.accentColor : .primary)
                    .bold()
                    .padding(8)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundStyle(selectedTime == time ? Color.accentColor : .primary))
                    .padding(6)
            }
        }
    }
}

#Preview {
    SelectTimeView(selectedTime: .constant(Date()), showConfirmTimeDate: .constant(false), times: [Date()])
        .environmentObject(CalenderViewModel(database: FirebaseService()))
}
