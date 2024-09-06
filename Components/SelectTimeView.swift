//
//  SelectTimeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct SelectTimeView: View {
    @Binding var selectedTime: Date
    var selectTime: [Date]
    var body: some View {
        ForEach(selectTime, id: \.self) { time in
            Button {
                withAnimation {
                    selectedTime = time
                }
            } label: {
                Text(time.timeFromDate())
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
    SelectTimeView(selectedTime: .constant(Date()), selectTime: [Date()])
}
