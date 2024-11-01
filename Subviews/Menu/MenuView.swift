//
//  MenuView.swift
//  Journal
//
//  Created by Shaquille McGregor on 07/09/2024.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @State private var selectedOption: Page? = nil
    @Binding var isMenuShowing: Bool
    @Binding var selectedTab: Int
    var body: some View {
        ZStack {
            if isMenuShowing {
                Rectangle()
                    .foregroundStyle(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture { isMenuShowing.toggle() }
                HStack {
                    VStack(alignment: .leading, spacing: 32) {
                        menuHeader
                        VStack {
                            
                        }
                        ForEach(Page.allCases) { page in
                            Button {
                                selectedOption = page
                                selectedTab = page.rawValue
                                isMenuShowing = false
                            } label: {
                                MenuCellView(selectedOption: $selectedOption, page: page)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)
                    Spacer()
                }
                .transition(.move(edge: .leading))
            }
        }
        .task { await viewModel.fetchUser() }
        .animation(.easeInOut, value: isMenuShowing)
    }
}

#Preview {
    MenuView(isMenuShowing: .constant(true), selectedTab: .constant(0))
        .environmentObject(AuthViewModel())
}

extension MenuView {
    private var menuHeader: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "person.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Circle().foregroundStyle(Color.accentColor.opacity(0.5)))
                    .shadow(radius: 2)
                
                Text(viewModel.currentUser?.email ?? "email")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
        }
    }
}
