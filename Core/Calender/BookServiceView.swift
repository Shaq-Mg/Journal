//
//  BookServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct BookServiceView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @State private var isSelected = false
    @Binding var bookingConfirmed: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            List {
                Section("Services") {
                    ForEach(apptVM.services) { service in
                        BookServiceCellView(service: service)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isSelected = true
                            }
                            apptVM.service = service
                            let selectedTitle = service.title
                            apptVM.title = selectedTitle
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear(perform: apptVM.fetchServices)
            
            HStack {
                if let service = apptVM.service {
                    Text(service.title)
                        .font(.headline)
                }
                Spacer()
                Button(action: {
                    apptVM.addAppointment(name: apptVM.name, service: apptVM.title, date: apptVM.selectedTime ?? Date())
                    withAnimation(.spring()) {
                        bookingConfirmed.toggle()
                    }
                }, label: {
                    NextButton(isSave: true)
                })
                .disabled(apptVM.title.isEmpty)
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
            .environmentObject(ApptViewModel(database: FirebaseService()))
    }
}
