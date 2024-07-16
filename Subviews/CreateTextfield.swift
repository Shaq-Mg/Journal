//
//  CreateTextfield.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import SwiftUI

struct CreateTextfield: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption2)
            TextField(placeholder, text: $text)
            Divider()
        }
    }
}

struct CreateTextfield_Previews: PreviewProvider {
    static var previews: some View {
        CreateTextfield(text: .constant("Phone number"), title: "Phone number", placeholder: "")
    }
}
