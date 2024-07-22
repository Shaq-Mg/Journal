//
//  PreviewProvider.swift
//  Journal
//
//  Created by Shaquille McGregor on 14/07/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let authService = AuthService()
    let firebaseService = FirebaseService()
    let appointment = Appointment(name: "Kobe", service: Service(title: "Haircut", price: 25, duration: 40), date: Date())
    let client = Client(name: "Kobe", phoneNumber: "07901000000", nickname: nil, isFavourite: true)
    let service = Service(title: "Haircut & shave", price: 25.00, duration: 40)
}
