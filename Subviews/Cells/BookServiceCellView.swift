//
//  BookServiceCellView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct BookServiceCellView: View {
    @Binding var isSelected: Bool
    let service: Service
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .padding(10)
                .background(Circle().foregroundStyle(Color.accentColor))
                .shadow(radius: 2)
            
            Text(service.title)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark")
            } else {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundStyle(.secondary)
            }
        }
        .font(.system(size: 20, weight: .semibold))
    }
}

#Preview {
    BookServiceCellView(isSelected: .constant(true), service: Service(title: "Haircut", price: "£20", duration: "40 mins"))
}
