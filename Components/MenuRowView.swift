//
//  MenuRowView.swift
//  Journal
//
//  Created by Shaquille McGregor on 21/07/2024.
//

import SwiftUI

struct MenuRowView: View {
    let page: Page
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: page.iconName)
                .foregroundStyle(.indigo)
            Text(page.title)
        }
        .font(.system(size: 18, weight: .semibold))
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(page: .client)
    }
}
