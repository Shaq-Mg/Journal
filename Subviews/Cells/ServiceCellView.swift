//
//  ServiceCellView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ServiceCellView: View {
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

#Preview {
    ServiceCellView(service: Service(title: "Haircut", price: "£25", duration: "40 mins"))
}
