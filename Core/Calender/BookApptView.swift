//
//  BookApptView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct BookApptView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @Environment(\.dismiss) private var dismiss
    @AppStorage("hours") private var hours: Hours = .morning
    @State private var showConfirmTimeDate = false
    @State private var showNameAlert = false
    
    var currentDate: Date
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 30) {
                ReusableInputView(text: $apptVM.name, placeholder: "Client Name", imageName: "plus")
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
                            SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: apptVM.availableMorningTimes)
                        } else if hours == .afternoon {
                           SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: apptVM.availableAftenoonTimes)
                        } else if hours == .evening {
                            SelectTimeView(showConfirmTimeDate: $showConfirmTimeDate, times: apptVM.availableEveningTimes)
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
                _ = apptVM.generateMorningTimes()
                _ = apptVM.generateAfternoonTimes()
                _ = apptVM.generateEveningTimes()
            }
            .alert("Enter name", isPresented: $showNameAlert, actions: {
                TextField("Name", text: $apptVM.name)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        apptVM.selectedTime = nil
                        apptVM.name = ""
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
                        apptVM.selectMorningTimeSlot(apptVM.selectedTime ?? Date())
                    } else if hours == .afternoon {
                        apptVM.selectAfternoonTimeSlot(apptVM.selectedTime ?? Date())
                    } else if hours == .evening {
                        apptVM.selectEveningTimeSlot(apptVM.selectedTime ?? Date())
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
            .environmentObject(ApptViewModel(database: FirebaseService()))
    }
}

extension BookApptView {
    private var bookApptFooter: some View {
        HStack {
            if let time = apptVM.selectedTime {
                Text(time.dayViewDateFormat())
                    .font(.caption2)
            }
            
            if !apptVM.name.isEmpty && apptVM.selectedTime != nil {
                withAnimation(.easeInOut(duration: 1.0)) {
                    NavigationLink(destination: {
                        ConfirmApptView()
                            .environmentObject(apptVM)
                    }, label: {
                        NextButton()
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .environmentObject(apptVM)
                }
            }
        }
    }
}
