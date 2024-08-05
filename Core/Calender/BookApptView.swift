//
//  BookApptView.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import SwiftUI

struct BookApptView: View {
    @EnvironmentObject private var vm: CalenderViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var dates = [Date]()
    @State private var selectedDate = Date()
    @State private var name = ""
    var currentDate: Date
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 30) {
                ApptInputView(text: $name, title: "Name", action: { name = "" }, placeholder: "Name")
                
                ScrollView {
                    Text("Select a time")
                        .font(.system(size: 16, weight: .semibold))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                        ForEach(vm.times, id: \.self) { time in
                            Button {
                                withAnimation {
                                    selectedDate = time
                                }
                            } label: {
                                Text(time.timeFromDate())
                                    .font(selectedDate == time ? .callout : .caption)
                                    .foregroundStyle(selectedDate == time ? .indigo : .primary)
                                    .bold()
                                    .padding(8)
                                    .frame(width: UIScreen.main.bounds.width / 5)
                                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundStyle(selectedDate == time ? .indigo : .primary))
                                    .padding(8)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(currentDate.dayOfTheWeek())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(white: 0.95))
            .onAppear { self.dates = vm.availableDates.filter({ $0.monthDayYearFormat() == currentDate.monthDayYearFormat() }) }
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
            if !name.isEmpty {
                Button {
                    withAnimation(.easeInOut) {
                        vm.showConfirmedAppt = true
                    }
                } label: {
                    Text("Confirm booking")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                        .foregroundStyle(.indigo)
                }
                
            }
        }
    }
}

struct BookApptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookApptView(currentDate: Date())
        }
        .environmentObject(CalenderViewModel())
    }
}
