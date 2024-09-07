//
//  MenuCellView.swift
//  Journal
//
//  Created by Shaquille McGregor on 07/09/2024.
//

import SwiftUI

struct MenuCellView: View {
    @Binding var selectedOption: Page?
    let page: Page
    
    private var isSelected: Bool {
        return selectedOption == page
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: page.iconName)
                .foregroundStyle(isSelected ? .white : .indigo)
            Text(page.title)
                .foregroundStyle(isSelected ? .white : .black)
            Spacer()
        }
        .padding(.leading)
        .font(.system(size: 18, weight: .semibold))
        .frame(width: 216, height: 44)
        .background(isSelected ? Color.accentColor.opacity(0.8) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MenuCellView(selectedOption: .constant(.client), page: .client)
}
