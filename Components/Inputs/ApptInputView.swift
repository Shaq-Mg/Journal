//
//  ApptInputView.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct ApptInputView: View {
    @Binding var text: String
    let title: String
    let action: ()->()
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.black)
                .font(.footnote)
            
            VStack {
                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .textInputAutocapitalization(.none)
                    .overlay(alignment: .trailing) {
                        if !text.isEmpty {
                            withAnimation(.easeInOut) {
                                Button {
                                    action()
                                } label: {
                                    Text("Clear")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundStyle(.black))
        }
    }
}

#Preview {
    ApptInputView(text: .constant(""), title: "Name", action: { }, placeholder: "Name")
}
