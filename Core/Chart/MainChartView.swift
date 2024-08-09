//
//  MainChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import SwiftUI

struct MainChartView: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @Binding var showSideMenu: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            HeaderView(showSideMenu: $showSideMenu, title: authVM.currentUser?.name ?? "")
            VStack(spacing: 20) {
                ApptChartView()
                VStack(alignment: .leading) {
                    Text("Upcoming appointments")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            List {
                                ForEach(calenderVM.appointments) { appt in
                                    ApptRowView(appointment: appt)
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
        }
    }
}

struct MainChartView_Previews: PreviewProvider {
    static var previews: some View {
        MainChartView(showSideMenu: .constant(false))
            .environmentObject(AuthViewModel())
            .environmentObject(CalenderViewModel(service: dev.firebaseService))
    }
}
