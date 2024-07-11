//
//  RegistrationButton.swift
//  Journal
//
//  Created by Shaquille McGregor on 11/07/2024.
//

import SwiftUI

struct RegistrationButton: View {
    let title: String
    let isPressed: () -> ()
    var body: some View {
        Button {
            isPressed()
        } label: {
            Text(title)
                .font(.system(size: 20).bold())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

struct RegistrationButton_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationButton(title: "Sign In", isPressed: { })
    }
}
