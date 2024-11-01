//
//  ReusableInputView.swift
//  Journal
//
//  Created by Shaquille McGregor on 01/11/2024.
//

import SwiftUI

struct ReusableInputView: View {
    @Binding var text: String
    let placeholder: String
    let imageName: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: imageName)
                .foregroundStyle(Color("AccentColor"))
                .font(.system(size: 22, weight: .semibold))
            
            if text.isEmpty {
                Text(placeholder)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            } else {
                Text(text)
                    .foregroundStyle(.black)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.white)
        .cornerRadius(8)
    }
}

#Preview {
    ReusableInputView(text: .constant(""), placeholder: "Name", imageName: "plus.circle")
}
