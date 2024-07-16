//
//  ApptViewModel.swift
//  Journal
//
//  Created by Shaquille McGregor on 15/07/2024.
//

import Foundation

final class ApptViewModel: ObservableObject {
    @Published var appointments = [Appointment]()
}
