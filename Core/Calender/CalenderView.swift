//
//  CalenderView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct CalenderView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            CalenderHeaderView(selectedDate: $calenderVM.selectedDate)
            
            HStack {
                ForEach(calenderVM.days, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            calenderDays
        }
        .padding(.horizontal)
        .navigationTitle("Select a date")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .padding()
        .background(Color.init(white: 0.95))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "house.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.black)
                }
            }
        }
        .onChange(of: calenderVM.selectedMonth) {
            calenderVM.selectedDate = calenderVM.fetchSelectedMonth()
        }
    }
}

#Preview {
    NavigationStack {
        CalenderView()
            .environmentObject(ApptViewModel(database: FirebaseService()))
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}

extension CalenderView {
    private var calenderDays: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(calenderVM.fetchDates()) { value in
                VStack {
                    if value.day != -1 {
                        NavigationLink {
                            BookApptView(currentDate: value.date)
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
