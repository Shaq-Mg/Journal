//
//  Coordinator.swift
//  Journal
//
//  Created by Shaquille McGregor on 27/07/2024.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = [Page]()
    
    func push(page: Page) {
        path.append(page)
    }
    
    func reset() {
        path = []
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        switch page {
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
