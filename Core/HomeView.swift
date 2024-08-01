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
    @State private var selectedTab = 0
    @State private var isMenuShowing = false
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                MainChartView(showSideMenu: $isMenuShowing)
                    .environmentObject(authVM)
                    .tag(0)
                
                ClientView(showSideMenu: $isMenuShowing)
                    .environmentObject(clientVM)
                    .tag(1)
                
                ServiceView(showSideMenu: $isMenuShowing)
                    .environmentObject(serviceVM)
                    .tag(2)
                
                CalenderView(showSideMenu: $isMenuShowing)
                    .environmentObject(apptVM)
                    .tag(3)
                
                Text("Schedule View")
                    .environmentObject(apptVM)
                    .tag(4)
                
                SettingsView(showSideMenu: $isMenuShowing)
                    .environmentObject(authVM)
                    .tag(5)
            }
            .tint(.indigo)
            SideMenuView(isMenuShowing: $isMenuShowing, selectedTab: $selectedTab)
        }
        .task { await authVM.fetchCurrentUser() }
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
