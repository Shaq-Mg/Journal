//
//  ChartState.swift
//  Journal
//
//  Created by Shaquille McGregor on 03/09/2024.
//

import Foundation

enum ChartState: String, Identifiable, CaseIterable {
    case currentWeek = "Previous week"
    case previousWeek = "Current week"
    
    var id: String {
        return rawValue
    }
}
