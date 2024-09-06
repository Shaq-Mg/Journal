//
//  SettingsSectionView.swift
//  Journal
//
//  Created by Shaquille McGregor on 06/09/2024.
//

import SwiftUI

struct SettingsSectionView: View {
    let title: String
    let imageName: String
    let isPressed: () -> ()
    
    var body: some View {
        Button {
            isPressed()
        } label: {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: imageName)
                    .foregroundStyle(.indigo)
                Text(title)
            }
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(.black)
        }
    }
}

#Preview {
    SettingsSectionView(title: "Update email", imageName: "envelope.fill") {
        
    }
}
