//
//  RootView.swift
//  Journal
//
//  Created by Shaquille McGregor on 31/08/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            if authViewModel.userSession != nil {
                HomeView()
                    .environmentObject(authViewModel)
            } else {
                SignInView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootView()
            .environmentObject(AuthViewModel())
    }
}
