//
//  MenuView.swift
//  Journal
//
//  Created by Shaquille McGregor on 21/07/2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            HeaderView(onDismiss: true, title: "Menu")
            List {
                Section("Business") {
                    ForEach(Page.allCases, id:\.self) { page in
                        ZStack(alignment: .leading) {
                            NavigationLink(value: Page.allCases) {
                                MenuRowView(page: page)
                            }
                        }
                    }
                }
                Section("Settings"){
//                    MenuRowView(title: "Appearance", iconName: "moon.fill")
//                    MenuRowView(title: "Subscriptions", iconName: "iphone")
//                    MenuRowView(title: "Notifications", iconName: "bell.badge.fill")
//                    MenuRowView(title: "Contact us", iconName: "message.fill")
//                    MenuRowView(title: "Privacy policy", iconName: "shield.righthalf.filled")
                }
            }
            .navigationDestination(for: Page.self) { $0 }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MenuView()
        }
    }
}
