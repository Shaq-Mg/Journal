//
//  NextButton.swift
//  Journal
//
//  Created by Shaquille McGregor on 05/09/2024.
//

import SwiftUI

struct NextButton: View {
    @EnvironmentObject private var calenderVM: CalenderViewModel
    var isSave = false
    
    var body: some View {
        VStack {
            if isSave {
                HStack {
                    Text("Save")
                    Image(systemName: "checkmark")
                        .font(.system(size: 16))
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.accentColor))
            } else {
                Image(systemName: "arrow.right")
                    .padding(10)
                    .background(Circle().foregroundStyle(Color.accentColor))
            }
        }
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(.white)

    }
}

#Preview {
    NextButton()
        .environmentObject(CalenderViewModel(database: FirebaseService()))
}
