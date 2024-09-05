//
//  PreviewProvider.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
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
    let appointment = Appointment(name: "Kobe", service: "Haircut", date: Date())
    let client = Client(name: "Kobe Bryant", phoneNumber: "08001000002", nickname: nil, isFavourite: true)
    let service = Service(title: "Haircut & shave", price: "25.00", duration: "40")
}
