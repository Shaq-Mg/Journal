//
//  NavigationStepModifier.swift
//  Journal
//
//  Created by Shaquille McGregor on 28/07/2024.
//

import SwiftUI

struct NavigationStepModifier<Destinantion: View>: ViewModifier {
    
    @Binding var navigationStep: NavigationStep
    var onDismiss: (() -> Void)?
    @ViewBuilder var destination: () -> Destinantion
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $navigationStep.isPresented) {
                onDismiss?()
            } content: {
                destination()
            }
            .fullScreenCover(isPresented: $navigationStep.isCovered) {
                onDismiss?()
            } content: {
                destination()
            }
            .push(isPresented: $navigationStep.isPushed) {
                onDismiss?()
            } destination: {
                destination()
            }
    }
}

extension View {
    func navigationStep<Destinantion: View>(navigationStep: Binding<NavigationStep>, onDismiss: (() -> Void)? = nil, @ViewBuilder destination: @escaping () -> Destinantion) -> some View {
        self.modifier(NavigationStepModifier(navigationStep: navigationStep, onDismiss: onDismiss, destination: destination))
    }
}
