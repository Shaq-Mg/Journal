//
//  ChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @Binding var selectedChart: ChartState
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Bookings")
                    .font(.headline)
                Spacer()
                Picker("", selection: $selectedChart) {
                    ForEach(ChartState.allCases) { value in
                        Text(value.rawValue)
                            .tag(value)
                            .onTapGesture {
                                withAnimation(.spring(duration: 1.0)) {
                                    selectedChart = value
                                }
                            }
                    }
                }
            }
            if selectedChart == .previousWeek {
                PreviousWeekChart()
            } else if selectedChart == .currentWeek {
                CurrentWeekChart()
            }
        }
    }
}

#Preview {
    ChartView(selectedChart: .constant(.currentWeek))
}

struct PreviousWeekChart: View {
    let data = Journal.previousSevenDays()
    
    var body: some View {
        Chart {
            RuleMark(y: .value("Goal", 14))
                .foregroundStyle(.black.opacity(0.2))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            
            ForEach(data) { value in
                BarMark(x: .value("Day", value.date, unit: .day),
                        y: .value("Booking", value.booking))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .chartXAxis {
            AxisMarks { mark in
                AxisValueLabel()
            }
        }
        .chartYAxis {
            AxisMarks { mark in
                AxisValueLabel()
            }
        }
    }
}

struct CurrentWeekChart: View {
    let data = Journal.currentWeek()
    
    var body: some View {
        Chart {
            RuleMark(y: .value("Goal", 14))
                .foregroundStyle(.black.opacity(0.2))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            
            ForEach(data) { value in
                BarMark(x: .value("Day", value.date, unit: .day),
                        y: .value("Booking", value.booking))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .chartXAxis {
            AxisMarks { mark in
                AxisValueLabel()
            }
        }
        .chartYAxis {
            AxisMarks { mark in
                AxisValueLabel()
            }
        }
    }
}
