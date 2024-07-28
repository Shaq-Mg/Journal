//
//  MenuHeaderView.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.dismiss) var dismiss
    var onDismiss = false
    let title: String
    
    var body: some View {
        VStack {
            if onDismiss {
                HStack {
                    Text("------")
                        .foregroundStyle(.clear)
                    Spacer()
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Button {
                        dismiss()
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
        HeaderView(title: "Menu")
    }
}
