//
//  SelectServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct SelectServiceView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @EnvironmentObject private var serviceVM: ServiceViewModel
    @Binding var bookingConfirmed: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            List {
                Section("Services") {
                    ForEach(serviceVM.services) { service in
                        ZStack(alignment: .leading) {
                            BookServiceCellView(title: service.title)
                                .onTapGesture {
                                    
                                }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear(perform: serviceVM.fetchServices)
            
            Button(action: {
                calenderVM.bookAppointment(name: calenderVM.name, title: calenderVM.title, time: calenderVM.selectedTime)
                withAnimation(.spring()) {
                    bookingConfirmed.toggle()
                }
            }, label: {
               NextButton(isSave: true)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top)
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack {
        SelectServiceView(bookingConfirmed: .constant(false), currentDate: Date())
            .environmentObject(CalenderViewModel(service: FirebaseService()))
            .environmentObject(ServiceViewModel(firebaseService: FirebaseService()))
    }
}
