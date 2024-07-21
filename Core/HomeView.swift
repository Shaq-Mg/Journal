//
//  HomeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @EnvironmentObject private var settingsVM: SettingsViewModel
    var body: some View {
        TabView {
            MainChartView()
                .environmentObject(apptVM)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            CalenderView()
                .environmentObject(calenderVM)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Bookings")
                }
            SettingsView()
                .environmentObject(settingsVM)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Account")
                }
        }
        .tint(.indigo)
        .task { try? await authVM.fetchCurrentUser() }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(ApptViewModel())
            .environmentObject(CalenderViewModel())
            .environmentObject(SettingsViewModel(authService: dev.authService))
        
    }
}
