//
//  BookServiceCellView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct BookServiceCellView: View {
    let title: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "pencil")
                .foregroundStyle(.white)
                .padding(10)
                .background(Circle().foregroundStyle(Color.accentColor))
                .shadow(radius: 2)
            
            Text(title)
            
            Spacer()
            
            Circle()
                .frame(width: 8, height: 8)
                .foregroundStyle(.secondary)
            
        }
        .font(.system(size: 20, weight: .semibold))
    }
}

#Preview {
    BookServiceCellView(title: "Haircut")
}
