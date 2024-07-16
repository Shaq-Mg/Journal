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
    
    let appointment = Appointment(name: "Kobe", service: Service(title: "Haircut", price: 25, duartion: 40), date: Date())
    let client = Client(name: "Kobe", phoneNumber: "07901000000", isFavourite: true, notes: nil)
    let service = Service(title: "Haircut & shave", price: 25.00, duartion: 40)
}
