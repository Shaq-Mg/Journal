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
    @State private var isSelected = false
    @Binding var bookingConfirmed: Bool
    var currentDate: Date
    
    var body: some View {
        VStack {
            List {
                Section("Services") {
                    ForEach(serviceVM.services) { service in
                        BookServiceCellView(isSelected: $isSelected, service: service)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isSelected = true
                                }
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
