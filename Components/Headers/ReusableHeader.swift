//
//  ReusableHeader.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ReusableHeader: View {
    @Binding var showSideMenu: Bool
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
                    Button {
                        showSideMenu.toggle()
                    } label: {
                       Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.accentColor)
    }
}

#Preview {
    ReusableHeader(showSideMenu: .constant(false), title: "Settings")
}
