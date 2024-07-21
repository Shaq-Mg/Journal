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
            if isNavigate {
                HStack {
                    Text("------")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Button {
                        isDismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.white)
                            .font(.system(size: 14, weight: .semibold))
                    }
                }
            } else {
                HStack {
                    Text("")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Text("")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
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
