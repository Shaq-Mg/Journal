//
//  CreateServiceView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct CreateServiceView: View {
    @EnvironmentObject var vm: ServiceViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                ReusableCapsule()
                    .padding(.top, 14)
                
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
                    Text("Save".uppercased())
                }
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.bottom, 62)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)
            .fontWeight(.semibold)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    CreateServiceView()
        .environmentObject(ServiceViewModel(firebaseService: FirebaseService()))
    
}
