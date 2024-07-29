//
//  SideMenuView.swift
//  Journal
//
//  Created by Shaquille McGregor on 29/07/2024.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showSideMenu: Bool
    @State private var selectedOption: Page? = nil
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 32) {
                HStack(spacing: 16) {
                    Text("S")
                        .padding()
                        .background(Circle().foregroundStyle(.secondary.opacity(0.2)))
                        .shadow(radius: 2)
                    Text("Email")
                        .font(.headline)
                }
                Spacer()
                ForEach(Page.allCases, id:\.self) { page in
                    MenuRowView(page: page)
                }
                Spacer()
            }
            .frame(width: 270)
            Spacer()
            Rectangle()
                .opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    showSideMenu.toggle()
                }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showSideMenu: .constant(true))
    }
}
