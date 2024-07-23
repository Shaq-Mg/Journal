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
    @EnvironmentObject private var clientVM: ClientViewModel
    @EnvironmentObject private var serviceVM: ServiceViewModel
    var body: some View {
        TabView {
            MainChartView()
                .environmentObject(apptVM)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Content unavailable")
                .environmentObject(serviceVM)
                .tabItem {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Statistics")
                }
            
            SettingsView()
                .environmentObject(authVM)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Account")
                }
        }
        .tint(.indigo)
        .task { try? await authVM.fetchCurrentUser() }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(ApptViewModel())
            .environmentObject(CalenderViewModel())
            .environmentObject(ClientViewModel(firebaseService: dev.firebaseService))
            .environmentObject(ServiceViewModel(firebaseService: dev.firebaseService))
        
    }
}
