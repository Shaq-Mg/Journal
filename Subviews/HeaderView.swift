//
//  MenuHeaderView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct HeaderView: View {
    var isNavigate = false
    let title: String
    let isDismiss: () -> ()
    var body: some View {
        VStack {
            HStack {
                if isNavigate {
                    Text("------")
                        .foregroundStyle(.clear)
                } else {
                    Spacer()
                }
                Spacer()
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                if isNavigate {
                    Button {
                        isDismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .semibold))
                    }
                } else {
                    Spacer()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.indigo)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Menu", isDismiss: { })
    }
}
