//
//  RootView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomeView()
            } else {
                SignInView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RootView()
        }
        .environmentObject(AuthViewModel())
    }
}
