//
//  Page.swift
//  Journal
//
//  Created by Shaquille McGregor on 07/09/2024.
//

import Foundation

enum Page: Int, Hashable , CaseIterable {
    case home, client, service, bookings, schedule, settings
    
    var title: String {
        switch self {
        case .client: return "Clients"
        case .service: return "Services"
        case .bookings: return "Bookings"
        case .schedule: return "Schedule"
        case .home: return "Home"
        case .settings: return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .client: return "person.2.fill"
        case .service: return "handbag.fill"
        case .bookings: return "calendar"
        case .schedule: return "book.closed.fill"
        case .home: return "house.fill"
        case .settings: return "gear"
        }
    }
}

extension Page: Identifiable {
    var id: Int { return self.rawValue }
}

