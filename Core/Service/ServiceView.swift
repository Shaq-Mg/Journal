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
    @Binding var showSideMenu: Bool
    var body: some View {
        VStack {
            HeaderView(showSideMenu: $showSideMenu, title: "Services")
            List {
                ForEach(vm.filteredServices) { service in
                    ZStack(alignment: .leading) {
                        if vm.filteredServices.isEmpty {
                            Text("No services available")
                        } else {
                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                EmptyView()
                            }
                            .opacity(0)
                            ServiceRowView(service: service)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .overlay(alignment: .bottomTrailing, content: {
                HStack {
                    SearchBarView(searchText: $vm.searchText)
                    Button {
                        isShowNewService.toggle()
                    } label: {
                        HStack {
                            CreateNavButton()
                                .padding()
                        }
                    }
                }
            })
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
            ServiceView(showSideMenu: .constant(false))
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
