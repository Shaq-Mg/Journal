//
//  CreateNavButton.swift
//  Journal
//
//  Created by Shaquille McGregor on 16/07/2024.
//

import SwiftUI

struct CreateNavButton: View {
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .font(.system(size: 8, weight: .bold))
                .padding(4)
                .overlay(Circle().stroke(lineWidth: 2))
                .foregroundStyle(.indigo)
        }
    }
}

struct CreateNavButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateNavButton()
    }
}
