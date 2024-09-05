//
//  ChartView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State var selectedChart: ChartState = .nextWeek
    @State var isLoading = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Bookings")
                    .font(.headline)
                Spacer()
                Picker("", selection: $selectedChart) {
                    Text(selectedChart.title)
                        .tag(0)
                    
                    Text(selectedChart.title)
                        .tag(1)
                }
            }
            if selectedChart == .nextWeek {
                withAnimation(.easeInOut(duration: 1.0)) {
                    PreviousWeekChart()
                }
            } else if selectedChart == .previousWeek {
                withAnimation(.easeInOut(duration: 1.0)) {
                    NextWeekChart()
                }
            }
        }
    }
}

#Preview {
    ChartView()
}

struct PreviousWeekChart: View {
    let lastWeekData: [Journal] = [
        .init(booking: 10, date: Date.from(year: 2024, month: 1, day: 1)),
        .init(booking: 14, date: Date.from(year: 2024, month: 1, day: 2)),
        .init(booking: 17, date: Date.from(year: 2024, month: 1, day: 3)),
        .init(booking: 11, date: Date.from(year: 2024, month: 1, day: 4)),
        .init(booking: 15, date: Date.from(year: 2024, month: 1, day: 5)),
        .init(booking: 10, date: Date.from(year: 2024, month: 1, day: 6)),
        .init(booking: 0, date: Date.from(year: 2024, month: 1, day: 7))
    ]
    var body: some View {
        Chart {
            RuleMark(y: .value("Goal", 14))
                .foregroundStyle(.black.opacity(0.2))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            
            ForEach(lastWeekData) { value in
                BarMark(x: .value("Day", value.date, unit: .day),
                        y: .value("Booking", value.booking))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
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

struct NextWeekChart: View {
    let nextWeekData: [Journal] = [
        .init(booking: 12, date: Date.from(year: 2024, month: 1, day: 8)),
        .init(booking: 21, date: Date.from(year: 2024, month: 1, day: 9)),
        .init(booking: 20, date: Date.from(year: 2024, month: 1, day: 10)),
        .init(booking: 14, date: Date.from(year: 2024, month: 1, day: 11)),
        .init(booking: 15, date: Date.from(year: 2024, month: 1, day: 12)),
        .init(booking: 0, date: Date.from(year: 2024, month: 1, day: 13)),
        .init(booking: 0, date: Date.from(year: 2024, month: 1, day: 14))
    ]
    var body: some View {
        Chart {
            RuleMark(y: .value("Goal", 14))
                .foregroundStyle(.black.opacity(0.2))
                .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
            
            ForEach(nextWeekData) { value in
                BarMark(x: .value("Day", value.date, unit: .day),
                        y: .value("Booking", value.booking))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
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
