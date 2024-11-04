//
//  ScheduleView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/11/2024.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @State private var showDayView = false
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Schedule")
            Spacer()
            VStack(spacing: 20) {
                calenderHeader
                HStack {
                    ForEach(calenderVM.days, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                scheduleDays
            }
            .padding(.horizontal)
            Spacer()
        }
        .onChange(of: calenderVM.selectedMonth) {
            calenderVM.selectedDate = calenderVM.fetchSelectedMonth()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ScheduleView(showSideMenu: .constant(false))
            .environmentObject(ApptViewModel(database: FirebaseService()))
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}

extension ScheduleView {
    private var calenderHeader: some View {
        HStack(spacing: 12) {
            Button {
                withAnimation {
                    calenderVM.selectedMonth -= 1
                }
            } label: {
                Image(systemName: "arrow.left")
                    .fontWeight(.semibold)
            }
            
            Spacer()
            Text(calenderVM.selectedDate.monthAndYear())
                .foregroundStyle(.black)
            Spacer()
            
            Button {
                withAnimation {
                    calenderVM.selectedMonth += 1
                }
            } label: {
                Image(systemName: "arrow.right")
                    .fontWeight(.semibold)
            }
        }
        .font(.system(size: 20))
        .foregroundStyle(Color.accentColor)
    }
    
    private var scheduleDays: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(calenderVM.fetchDates()) { value in
                VStack {
                    if value.day != -1 {
                        NavigationLink {
                            DayView(showSideMenu: $showSideMenu, currentDate: value.date)
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
                                                    .foregroundStyle(Color.accentColor)
                                                    .shadow(radius: 1)
                                            }
                                        }
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
