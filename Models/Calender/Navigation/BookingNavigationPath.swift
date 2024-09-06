//
//  BookingPath.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import Foundation
import SwiftUI

enum BookingNavigationPath: Hashable, View {
    case timeScreen(selectedDate: Date)
    case serviceScreen(selectedDate: Date)
    case confirmScreen
    
    var body: some View {
        switch self {
        case .timeScreen(let selectedDate):
            BookApptView(currentDate: selectedDate)
        case .serviceScreen(let selectedDate):
            SelectServiceView(currentDate: selectedDate)
        case .confirmScreen:
            DayView()
        }
    }
}
