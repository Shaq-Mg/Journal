//
//  ScheduleView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/08/2024.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var apptVM: ApptViewModel
    @EnvironmentObject var vm: CalenderViewModel
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            HeaderView(showSideMenu: $showSideMenu, title: "Schedule")
            NavigationStack {
                VStack(spacing: 20) {
                    SelectDateHeader(selectedDate: $vm.selectedDate)
                    
                    HStack {
                        ForEach(vm.days, id: \.self) { day in
                            Text(day)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    scheduleCalender
                }
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal)
                .onChange(of: vm.selectedMonth) { newValue in
                    vm.selectedDate = vm.fetchSelectedMonth()
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView(showSideMenu: .constant(false))
            .environmentObject(ApptViewModel(firebaseService: dev.firebaseService))
            .environmentObject(CalenderViewModel())
    }
}

extension ScheduleView {
    private var scheduleCalender: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(vm.fetchDates()) { value in
                VStack {
                    if value.day != -1 {
                        let hasAppts = vm.availableDays.contains(value.date.monthDayYearFormat())
                        NavigationLink {
                            DayView(showSideMenu: $showSideMenu)
                                .environmentObject(apptVM)
                        } label: {
                            Text("\(value.day)")
                                .bold()
                                .foregroundStyle(value.date.monthDayYearFormat() == Date().monthDayYearFormat() ? .white : .black)
                                .background(
                                    ZStack(alignment: .bottom) {
                                        Circle()
                                            .frame(width: 34, height: 34)
                                            .foregroundStyle(.clear)
                                        ZStack {
                                            if value.date.monthDayYearFormat() == Date().monthDayYearFormat() {
                                                Circle()
                                                    .frame(width: 36, height: 36)
                                                    .foregroundStyle(.indigo)
                                                    .shadow(radius: 1)
                                            }
                                        }
                                        Circle()
                                            .frame(width: 5, height: 5)
                                            .foregroundStyle(hasAppts ? .indigo : .clear)
                                    })
                        }
                    } else {
                        Text("")
                    }
                }
                .font(.system(size: 20, weight: .semibold))
                .frame(width: 32, height: 32)
            }
        }
    }
}
