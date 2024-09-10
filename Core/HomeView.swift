//
//  HomeView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/09/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @EnvironmentObject private var clientVM: ClientViewModel
    @EnvironmentObject private var serviceVM: ServiceViewModel
    @State private var selectedTab = 0
    @State private var isMenuShowing = false
    var body: some View {
        ZStack {
            NavigationStack {
                TabView(selection: $selectedTab) {
                    HomeChartView(showSideMenu: $isMenuShowing)
                        .environmentObject(authVM)
                        .tag(0)
                    
                    ClientView(showSideMenu: $isMenuShowing)
                        .environmentObject(clientVM)
                        .tag(1)
                    
                    ServiceView(showSideMenu: $isMenuShowing)
                        .environmentObject(serviceVM)
                        .tag(2)
                    
                    Text("Schedule View")
                        .environmentObject(calenderVM)
                        .tag(3)
                    
                    SettingsView(showSideMenu: $isMenuShowing)
                        .environmentObject(authVM)
                        .tag(4)
                }
                .tint(Color.accentColor)
            }
            MenuView(isMenuShowing: $isMenuShowing, selectedTab: $selectedTab)
                .environmentObject(authVM)
        }
        .task { await authVM.fetchUser() }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    NavigationStack {
//        let database = FirebaseService()
//        HomeView()
//            .environmentObject(AuthViewModel())
//            .environmentObject(CalenderViewModel(service: service))
//            .environmentObject(ClientViewModel(firebaseService: service))
//            .environmentObject(ServiceViewModel(firebaseService: service))
//    }
//}
