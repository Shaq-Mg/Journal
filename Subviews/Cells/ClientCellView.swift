//
//  ClientCellView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ClientCellView: View {
    let client: Client
    var body: some View {
        HStack {
            Circle()
                .frame(width: 35, height: 35)
                .foregroundStyle(.secondary)
                .overlay {
                    Text((client.name.prefix(1).capitalized))
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                }
            VStack(alignment: .leading, spacing: 6) {
                Text(client.name)
                    .font(.system(size: 18, design: .rounded).bold())
            }
            Spacer()
            if client.isFavourite {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.indigo)
            }
        }
    }
}

#Preview {
    ClientCellView(client: Client(name: "Shaquille O'neil", phoneNumber: "06000000400", nickname: nil, isFavourite: true))
}
