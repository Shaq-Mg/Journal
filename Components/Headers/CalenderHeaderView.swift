//
//  CalenderHeaderView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct CalenderHeaderView: View {
    @EnvironmentObject var vm: CalenderViewModel
    @Binding var selectedDate: Date
    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Text(selectedDate.monthAndYear())
                Image(systemName: "book")
            }
            .foregroundStyle(.black)
            Spacer()
            Button {
                withAnimation {
                    vm.selectedMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .fontWeight(.semibold)
            }
            .disabled(vm.isPreviousMonthDisabled()) 
            
            Button {
                withAnimation {
                    vm.selectedMonth += 1
                }
            } label: {
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
            }
        }
        .font(.system(size: 20))
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    CalenderHeaderView(selectedDate: .constant(Date()))
        .environmentObject(CalenderViewModel(service: FirebaseService()))
}
