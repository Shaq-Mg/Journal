//
//  ConfirmApptHeaderView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct ConfirmApptHeaderView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: imageName)
                .foregroundStyle(Color.accentColor)
            
            Text(text)
                .font(.system(size: 16, weight: .semibold))
        }
        .font(.system(size: 20, weight: .semibold))
    }
}

#Preview {
    ConfirmApptHeaderView(imageName: "clock", text: "13:00 PM")
}
