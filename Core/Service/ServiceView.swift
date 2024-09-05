//
//  ServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ServiceView: View {
    @EnvironmentObject var vm: ServiceViewModel
    @State private var isShowNewService = false
    @Binding var showSideMenu: Bool
    var body: some View {
        VStack {
            ReusableHeader(showSideMenu: $showSideMenu, title: "Services")
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
                            ServiceCellView(service: service)
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
                            CreateButton()
                                .padding()
                        }
                    }
                }
            })
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
                    NavigationStack {
                        CreateButton()
                    }
                }
            }
        }
    }
}

#Preview {
    ServiceView(showSideMenu: .constant(false))
        .environmentObject(ServiceViewModel(firebaseService: FirebaseService()))
}
