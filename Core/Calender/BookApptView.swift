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
    @State private var showConfirmTimeDate = false
    
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
                           SelectTimeView(selectedTime: $calenderVM.selectedTime, showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableMorningTimes)
                        } else if hours == .afternoon {
                           SelectTimeView(selectedTime: $calenderVM.selectedTime, showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableAftenoonTimes)
                        } else if hours == .evening {
                            SelectTimeView(selectedTime: $calenderVM.selectedTime, showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableEveningTimes)
                        }
                    }
                }
                Divider()
                bookApptFooter
            }
            .padding(.horizontal)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear {
                _ = calenderVM.generateMorningTimes()
                _ = calenderVM.generateAfternoonTimes()
                _ = calenderVM.generateEveningTimes()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .confirmationDialog("Select time", isPresented: $showConfirmTimeDate, titleVisibility: .visible) {
            Button("Yes") {
                DispatchQueue.main.async {
                    if hours == .morning {
                        calenderVM.selectMorningTimeSlot(calenderVM.selectedTime ?? Date())
                    } else if hours == .afternoon {
                        calenderVM.selectAfternoonTimeSlot(calenderVM.selectedTime ?? Date())
                    } else if hours == .evening {
                        calenderVM.selectEveningTimeSlot(calenderVM.selectedTime ?? Date())
                    }
                }
            }
        } message: {
            Text("Do you want to select this time?")
        }
    }
}

#Preview {
    NavigationStack {
        BookApptView(currentDate: Date())
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}

extension BookApptView {
    private var bookApptFooter: some View {
        HStack {
            if let time = calenderVM.selectedTime {
                Text(time.dayViewDateFormat())
                    .font(.caption2)
            }
            
            if !calenderVM.name.isEmpty && calenderVM.selectedTime != nil {
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
    }
}
