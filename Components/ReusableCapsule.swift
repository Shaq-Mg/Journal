//
//  ReusableCapsule.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import SwiftUI

struct ReusableCapsule: View {
    var body: some View {
        Capsule()
            .foregroundStyle(Color(.systemGray4))
            .frame(width: 48, height: 6)
    }
}

#Preview {
    ReusableCapsule()
}
