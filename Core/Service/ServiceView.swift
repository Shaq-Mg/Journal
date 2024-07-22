//
//  ServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 22/07/2024.
//

import SwiftUI

struct ServiceView: View {
    @EnvironmentObject var vm: ServiceViewModel
    @State private var isShowNewService = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.filteredServices) { service in
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: ServiceDetailView(service: service)) {
                            EmptyView()
                        }
                        .opacity(0)
                        ServiceRowView(service: service)
                    }
                }
            }
            .onAppear { vm.fetchServices() }
            .searchable(text: $vm.searchText, prompt: "Search services")
            .onAppear { vm.fetchServices() }
            .sheet(isPresented: $isShowNewService) {
                CreateServiceView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowNewService.toggle()
                } label: {
                    CreateNavButton()
                }
            }
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ServiceView()
        }
        .environmentObject(ServiceViewModel(firebaseService: dev.firebaseService))
    }
}

struct ServiceRowView: View {
    let service: Service
    var body: some View {
        HStack {
            Text(service.title)
                .font(.headline)
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("Price: £\(service.price)")
                    .foregroundStyle(.black)
                Text("\(service.duration)mins")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}
