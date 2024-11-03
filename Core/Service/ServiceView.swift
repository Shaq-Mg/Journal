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
            Spacer()
            if vm.filteredServices.isEmpty {
                Text("No services available")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            } else {
                List {
                    ForEach(vm.filteredServices) { service in
                        ZStack {
                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                EmptyView()
                            }
                            .opacity(0)

                            ServiceCellView(service: service)
                        }
                    }
                    .onDelete(perform: vm.deleteService)
                }
                .listStyle(.plain)
            }
        }
        .onAppear { vm.fetchServicesWithListener() }
        .sheet(isPresented: $isShowNewService) {
            CreateServiceView()
        }
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
