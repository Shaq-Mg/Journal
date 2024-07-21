//
//  MainChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import SwiftUI

struct MainChartView: View {
    @EnvironmentObject private var apptVM: ApptViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            HeaderView(title: authVM.currentUser?.name ?? "", isDismiss: { })
            VStack(spacing: 20) {
                ApptChartView()
                VStack(alignment: .leading) {
                    Text("Upcoming appointments")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            List {
                                ForEach(apptVM.appointments) { appt in
                                    ApptRowView(appointment: appt)
                                }
                            }
                        }
                        NavigationLink {
                            MenuView()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(10)
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
        MainChartView()
            .environmentObject(ApptViewModel())
            .environmentObject(AuthViewModel())
    }
}
