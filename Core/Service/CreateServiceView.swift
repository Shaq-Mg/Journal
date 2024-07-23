//
//  CreateServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 22/07/2024.
//

import SwiftUI

struct CreateServiceView: View {
    @EnvironmentObject var vm: ServiceViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            CreateTextfield(text: $vm.title, title: "Title", placeholder: "Title")
            CreateTextfield(text: $vm.price, title: "Price", placeholder: "Amount", isDecimal: true)
            CreateTextfield(text: $vm.duration, title: "Duration", placeholder: "Minutes", isDecimal: true)
            Spacer()
            Button {
                vm.saveService(title: vm.title, price: vm.price, duration: vm.duration)
                dismiss()
                vm.title = ""
                vm.price = ""
                vm.duration = ""
            } label: {
                Text("Save")
            }
            .foregroundStyle(.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(.indigo)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 1).foregroundStyle(.secondary))
            .shadow(radius: 5)
        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.black)
            }
        }
        .fontWeight(.semibold)
    }
}

struct CreateServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateServiceView()
        }
        .environmentObject(ServiceViewModel(firebaseService: dev.firebaseService))
    }
}
