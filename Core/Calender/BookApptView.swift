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
    @State private var showNameAlert = false
    
    var currentDate: Date
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 30) {
                ReusableInputView(text: $calenderVM.name, placeholder: "Client Name", imageName: "plus")
                    .onTapGesture { showNameAlert.toggle() }
                    .padding(.top)
                Divider()
                
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
                            SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableMorningTimes)
                        } else if hours == .afternoon {
                           SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableAftenoonTimes)
                        } else if hours == .evening {
                            SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: calenderVM.availableEveningTimes)
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
            .alert("Enter name", isPresented: $showNameAlert, actions: {
                TextField("Name", text: $calenderVM.name)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        calenderVM.selectedTime = nil
                        calenderVM.name = ""
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .foregroundStyle(.black)
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
            Text("Are you sure you want to select this time?")
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
