//
//  NavigationStep.swift
//  Journal
//
//  Created by Shaquille McGregor on 28/07/2024.
//

import SwiftUI

final class NavigationStep {
    var isPresented = false
    var isCovered = false
    var isPushed = false
    
    func present() {
        isPresented.toggle()
    }
    
    func cover() {
        isCovered.toggle()
    }
    
    func push() {
        isPushed.toggle()
    }
}
