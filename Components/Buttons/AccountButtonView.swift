//
//  AccountButtonView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct AccountButtonView: View {
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

struct AccountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AccountButtonView(title: "Sign out", imageName: "gearshape", isPressed: { })
    }
}
