//
//  SearchBarView.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading)
            TextField("Search...", text: $searchText)
                .padding(.leading, 6)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(RoundedRectangle(cornerRadius: 20).foregroundStyle(.secondary.opacity(0.06)))
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
