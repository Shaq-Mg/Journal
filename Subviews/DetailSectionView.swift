//
//  DetailSectionView.swift
//  Journal
//
//  Created by Shaquille McGregor on 22/07/2024.
//

import SwiftUI

struct DetailSectionView: View {
    let title: String
    let description: String
    var body: some View {
        HStack {
            Text(title + ":")
                .font(.callout)
                .foregroundStyle(.secondary)
            Spacer()
            Text(description)
        }
    }
}

struct DetailSectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSectionView(title: "title", description: "Haircut")
    }
}
