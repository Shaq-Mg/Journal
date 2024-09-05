//
//  SelectDetailView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct SelectDetailView: View {
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title + ":")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(description)
        }
    }
}

#Preview {
    SelectDetailView(title: "Haircut", description: "40 mins")
}
