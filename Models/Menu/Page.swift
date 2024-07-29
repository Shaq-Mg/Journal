//
//  Page.swift
//  Journal
//
//  Created by Shaquille McGregor on 27/07/2024.
//

import Foundation
import SwiftUI

enum Page: Int, Hashable , CaseIterable {
    case home, client, service, bookings, schedule
    
    var title: String {
        switch self {
        case .client: return "Client"
        case .service: return "Service"
        case .bookings: return "Bookings"
        case .schedule: return "Schedule"
        case .home: return "Home"
            
        }
    }
    
    var iconName: String {
        switch self {
        case .client: return "person.2.fill"
        case .service: return "handbag.fill"
        case .bookings: return "calendar"
        case .schedule: return "book.closed.fill"
        case .home: return "house"
            
        }
    }
}
