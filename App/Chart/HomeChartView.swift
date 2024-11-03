//
//  HomeChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import SwiftUI

struct HomeChartView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var chartVM: ChartViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @AppStorage("chartTapped") private var selectedChart: ChartState = .currentWeek
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Home")
            VStack(spacing: 20) {
                ChartView(selectedChart: $selectedChart)
                VStack(alignment: .leading) {
                    Text("Upcoming appointments")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            List {
                                ForEach(chartVM.upcomingAppointments) { appt in
                                    ApptCellView(appointment: appt)
                                }
                            }
                        }
                        NavigationLink {
                            CalenderView()
                                .environmentObject(apptVM)
                                .environmentObject(calenderVM)
                        } label: {
                            Image(systemName: "plus")
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(Circle())
                        .padding()
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .task {
                chartVM.fetchUpcomingAppts(from: Date())
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeChartView(showSideMenu: .constant(false))
            .environmentObject(ApptViewModel(database: FirebaseService()))
            .environmentObject(AuthViewModel())
            .environmentObject(ChartViewModel(service: FirebaseService()))
            .environmentObject(CalenderViewModel(database: FirebaseService()))
    }
}
