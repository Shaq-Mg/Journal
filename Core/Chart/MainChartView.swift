//
//  MainChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import SwiftUI

struct MainChartView: View {
    @EnvironmentObject var vm: ApptViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            HeaderView(title: "Home", isDismiss: { })
            VStack(spacing: 20) {
                ApptChartView()
                VStack(alignment: .leading) {
                    Text("Upcoming appointments")
                        .font(.system(size: 20, weight: .semibold))
                    
                    ZStack(alignment: .bottomTrailing) {
                        ScrollView {
                            List {
                                ForEach(vm.appointments) { appt in
                                    ApptRowView(appointment: appt)
                                }
                            }
                        }
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                            Text("Book")
                        }
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.black))
                        .padding()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MainChartView_Previews: PreviewProvider {
    static var previews: some View {
        MainChartView()
            .environmentObject(ApptViewModel())
    }
}
