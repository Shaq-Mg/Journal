//
//  SideMenuView.swift
//  Journal
//
//  Created by Shaquille McGregor on 29/07/2024.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    @Binding var isMenuShowing: Bool
    @Binding var selectedTab: Int
    @State private var selectedOption: Page? = nil
    var body: some View {
        ZStack {
            if isMenuShowing {
                Rectangle()
                    .opacity(0.5)
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
                                MenuRowView(selectedOption: $selectedOption, page: page)
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
        .task { await viewModel.fetchCurrentUser() }
        .animation(.easeInOut, value: isMenuShowing)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isMenuShowing: .constant(true), selectedTab: .constant(0))
            .environmentObject(AuthViewModel())
    }
}

extension SideMenuView {
    private var menuHeader: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "person.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Circle().foregroundStyle(.secondary.opacity(0.2)))
                    .shadow(radius: 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.currentUser?.name ?? "name")
                        .font(.headline)
                        .shadow(radius: 2)
                    Text(viewModel.currentUser?.email ?? "email")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            Divider()
        }
    }
}
