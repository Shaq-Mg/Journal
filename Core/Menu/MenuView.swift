//
//  MenuView.swift
//  Journal
//
//  Created by Shaquille McGregor on 21/07/2024.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HeaderView(isNavigate: true, title: "Menu") {
                dismiss()
            }
            List {
                Section("Business") {
                    MenuRowView(image: "calendar", title: "Bookings")
                    MenuRowView(image: "person.2.fill", title: "Clients")
                    MenuRowView(image: "handbag.fill", title: "Services")
                    MenuRowView(image: "book.closed.fill", title: "Schedule")
                    MenuRowView(image: "personalhotspot", title: "Business page")
                }
                Section("Settings"){
                    MenuRowView(image: "moon.fill", title: "Appearance")
                    MenuRowView(image: "iphone", title: "Subscriptions")
                    MenuRowView(image: "bell.badge.fill", title: "Notifications")
                    MenuRowView(image: "message.fill", title: "Contact us")
                    MenuRowView(image: "shield.righthalf.filled", title: "Privacy policy")
                }
            }
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
