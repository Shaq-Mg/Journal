//
//  SelectServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct BookServiceView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @State private var isSelected = false
    @Binding var bookingConfirmed: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            List {
                Section("Services") {
                    ForEach(calenderVM.services) { service in
                        BookServiceCellView(service: service)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSelected = true
                            }
                            calenderVM.service = service
                            let selectedTitle = service.title
                            calenderVM.title = selectedTitle
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear(perform: calenderVM.fetchServices)
            
            HStack {
                if let service = calenderVM.service {
                    Text(service.title)
                        .font(.headline)
                }
                Spacer()
                Button(action: {
                    calenderVM.bookAppointment(name: calenderVM.name, title: calenderVM.title, time: calenderVM.selectedTime ?? Date())
                    withAnimation(.spring()) {
                        bookingConfirmed.toggle()
                    }
                }, label: {
                    NextButton(isSave: true)
                })
                .disabled(calenderVM.title.isEmpty)
                .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        BookServiceView(bookingConfirmed: .constant(false), currentDate: Date())
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}
