//
//  MenuRowView.swift
//  Journal
//
//  Created by Shaquille McGregor on 21/07/2024.
//

import SwiftUI

struct MenuRowView: View {
    let image: String
    let title: String
    let color: Color = .indigo
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: image)
                .foregroundStyle(color)
            Text(title)
        }
        .font(.system(size: 18, weight: .semibold))
    }
}

struct MenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        MenuRowView(image: "message.fill", title: "Contact us")
    }
}
