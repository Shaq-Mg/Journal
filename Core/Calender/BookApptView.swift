//
//  BookApptView.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import SwiftUI

struct BookApptView: View {
    @EnvironmentObject private var vm: CalenderViewModel
    @State private var dates = [Date]()
    @State private var selectedDate = Date()
    @State private var name = ""
    var currentDate: Date
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text(currentDate.dayOfTheWeek())
                    .font(.system(size: 16, weight: .semibold))
                ApptInputView(text: $name, title: "Name", placeholder: "Name")
                
                Text("Select a time")
                    .font(.system(size: 16, weight: .semibold))
                
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(vm.times, id: \.self) { time in
                            Button {
                                if !name.isEmpty {
                                    withAnimation {
                                        selectedDate = time
                                        vm.showConfirmedAppt = true
                                    }
                                }
                            } label: {
                                Text(time.timeFromDate())
                                    .foregroundStyle(.black)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundStyle(.indigo))
                                    .padding(8)
                            }
                        }
                    }
                }
            }
            .onAppear { self.dates = vm.availableDates.filter({ $0.monthDayYearFormat() == currentDate.monthDayYearFormat() }) }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $vm.showConfirmedAppt) {

            }
        }
    }
}

struct BookApptView_Previews: PreviewProvider {
    static var previews: some View {
        BookApptView(currentDate: Date())
            .environmentObject(CalenderViewModel())
    }
}
