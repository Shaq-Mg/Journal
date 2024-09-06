//
//  HomeChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import SwiftUI

struct HomeChartView: View {
    @EnvironmentObject private var chartVM: ChartViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @AppStorage("chartTapped") private var selectedChart: ChartState = .currentWeek
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            ReusableHeader(showSideMenu: $showSideMenu, title: authVM.currentUser?.name ?? "user")
            VStack(spacing: 20) {
                ChartView(selectedChart: $selectedChart)
                VStack(alignment: .leading) {
                    Text("Upcoming appointments")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            List {
                                ForEach(chartVM.appointments) { appt in
                                    ApptCellView(appointment: appt)
                                }
                            }
                        }
                        NavigationLink {
                            
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
                await authVM.fetchUser()
            }
        }
    }
}

#Preview {
    HomeChartView(showSideMenu: .constant(false))
        .environmentObject(ChartViewModel(service: FirebaseService()))
        .environmentObject(AuthViewModel())
}
