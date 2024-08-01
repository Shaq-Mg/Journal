//
//  MenuRowView.swift
//  Journal
//
//  Created by Shaquille McGregor on 21/07/2024.
//

import SwiftUI

struct MenuRowView: View {
    @Binding var selectedOption: Page?
    let page: Page
    
    private var isSelected: Bool {
        return selectedOption == page
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: page.iconName)
                .foregroundStyle(isSelected ? .black : .indigo)
            Text(page.title)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding(.leading)
        .font(.system(size: 18, weight: .semibold))
        .frame(width: 216, height: 44)
        .background(isSelected ? .indigo.opacity(0.2) : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(selectedOption: .constant(.client), page: .client)
    }
}
