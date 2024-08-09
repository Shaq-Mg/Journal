//
//  SelectDateHeader.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import SwiftUI

struct SelectDateHeader: View {
    @EnvironmentObject var vm: CalenderViewModel
    @Binding var selectedDate: Date
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    vm.selectedMonth -= 1
                }
            } label: {
                Image(systemName: "arrow.left")
            }
            
            Spacer()
            HStack {
                Text(selectedDate.monthAndYear())
                Image(systemName: "book")
            }
            .foregroundStyle(.black)
            Spacer()
            
            Button {
                withAnimation {
                    vm.selectedMonth += 1
                }
            } label: {
                Image(systemName: "arrow.right")
            }
        }
        .font(.system(size: 25))
        .foregroundStyle(.indigo)
    }
}

struct SelectDateHeader_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateHeader(selectedDate: .constant(Date()))
            .environmentObject(CalenderViewModel(service: dev.firebaseService))
    }
}
