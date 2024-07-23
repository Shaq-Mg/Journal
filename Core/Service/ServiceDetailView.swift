//
//  ServiceDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 22/07/2024.
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
                    HStack {
                        Circle()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.secondary)
                            .overlay {
                                Text((service.title.prefix(1).capitalized))
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                            }
                        Spacer()
                        Text(service.title)
                            .font(.title2.bold())
                    }
                    .padding(.vertical, 8)
                    DetailSectionView(title: "Price", description: String(service.price))
                    DetailSectionView(title: "Duration", description: String(service.duration))
                }
                .fontWeight(.semibold)
                Section("Update") {
                    Button {
                        showDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "minus.circle")
                            Text("Delete")
                        }
                        .font(.headline).bold()
                        .foregroundStyle(.indigo)
                        .padding(.vertical)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .confirmationDialog("Delete Client", isPresented: $showDeleteAlert) {
                Button("Yes") { vm.deleteService(serviceToDelete: service) }
            } message: {
                Text("Are you sure you want to delete this client?")
            }
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

struct ServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDetailView(service: dev.service)
            .environmentObject(ServiceViewModel(firebaseService: dev.firebaseService))
    }
}
