//
//  ApptInputView.swift
//  Journal
//
//  Created by Shaquille McGregor on 12/07/2024.
//

import SwiftUI

struct ApptInputView: View {
    @Binding var text: String
    let title: String
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
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundStyle(.black))
        }
    }
}

struct ApptInputView_Previews: PreviewProvider {
    static var previews: some View {
        ApptInputView(text: .constant(""), title: "Name", placeholder: "Name")
    }
}
