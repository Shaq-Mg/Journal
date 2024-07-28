//
//  Page.swift
//  Journal
//
//  Created by Shaquille McGregor on 27/07/2024.
//

import Foundation
import SwiftUI

enum Page: View, Hashable , CaseIterable {
    case client, service, bookings, schedule
    
    var title: String {
        switch self {
        case .client: return "Client"
        case .service: return "Service"
        case .bookings: return "Bookings"
        case .schedule: return "Schedule"
            
        }
    }
    
    var iconName: String {
        switch self {
        case .client: return "person.2.fill"
        case .service: return "handbag.fill"
        case .bookings: return "calendar"
        case .schedule: return "book.closed.fill"
            
        }
    }
    
    var body: some View {
        switch self {
        case .client:
            ClientView()
        case .service:
            ServiceView()
        case .bookings:
            CalenderView()
        case .schedule:
            EmptyView()
            
        }
    }
}
