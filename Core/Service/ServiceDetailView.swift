//
//  ServiceDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ServiceDetailView: View {
    @EnvironmentObject var vm: ServiceViewModel
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    let service: Service
    
    var body: some View {
        NavigationStack {
            List {
                Section("General") {
                    HStack(spacing: 10) {
                        Circle()
                            .frame(width: 33, height: 33)
                            .foregroundStyle(.secondary)
                            .overlay {
                                Text((service.title.prefix(1).capitalized))
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                            }
                        
                        Text(service.title)
                            .font(.title2.bold())
                    }
                    .padding(.vertical, 8)
                    SelectDetailView(title: "Price", description: String(service.price))
                    SelectDetailView(title: "Duration", description: String(service.duration))
                }
                .fontWeight(.semibold)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Service info")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ServiceDetailView(service: Service(title: "Haircut", price: "£25", duration: "40 mins"))
        .environmentObject(ServiceViewModel(firebaseService: FirebaseService()))
}
