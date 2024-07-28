//
//  NavigationPushViewModifier.swift
//  Journal
//
//  Created by Shaquille McGregor on 28/07/2024.
//

import SwiftUI

struct NavigationPushViewModifier<Destinantion: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @ViewBuilder var destination: () -> Destinantion
    var onDismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(isPresented: $isPresented, destination: destination)
            .onChange(of: isPresented) { newValue in
                if !newValue {
                    onDismiss?()
                }
            }
    }
}

extension View {
    func push<Destinantion: View>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder destination: @escaping () -> Destinantion) -> some View {
        self.modifier(NavigationPushViewModifier(isPresented: isPresented, destination: destination, onDismiss: onDismiss))
    }
}
