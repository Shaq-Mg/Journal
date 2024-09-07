//
//  BookApptView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct BookApptView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hours") private var hours: Hours = .morning
    
    var currentDate: Date
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 30) {
                ApptInputView(text: $calenderVM.name, title: "Name", action: { calenderVM.name = "" }, placeholder: "Name")
                
                HStack {
                    Text("Select a time")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    Picker("", selection: $hours) {
                        ForEach(Hours.allCases) { time in
                            Text(time.rawValue)
                                .font(.system(size: 16, weight: .medium))
                                .tag(time)
                        }
                    }
                }
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1)) {
                        if hours == .morning {
                            SelectTimeView(selectedTime: $calenderVM.selectedTime, times: calenderVM.generateMorningTimes())
                        } else if hours == .afternoon {
                            SelectTimeView(selectedTime: $calenderVM.selectedTime, times: calenderVM.generateAfternoonTimes())
                        } else if hours == .evening {
                            SelectTimeView(selectedTime: $calenderVM.selectedTime, times: calenderVM.generateEveningTimes())
                        }
                    }
                }
                .padding(.bottom)
                if !calenderVM.name.isEmpty {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        NavigationLink(destination: {
                            ConfirmApptView()
                                .environmentObject(calenderVM)
                        }, label: {
                            NextButton()
                        })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .environmentObject(calenderVM)
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear {  }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookApptView(currentDate: Date())
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}
