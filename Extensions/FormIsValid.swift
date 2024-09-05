//
//  FormIsValid.swift
//  Journal
//
//  Created by Shaquille McGregor on 02/09/2024.
//

import Foundation

extension SignInView {
    var formIsValid: Bool {
        return !authViewModel.email.isEmpty
        && authViewModel.email.contains("@")
        && !authViewModel.password.isEmpty
        && authViewModel.password.count >= 5
    }
}

extension RegistrationView {
    var formIsValid: Bool {
        return !authViewModel.email.isEmpty
        && authViewModel.email.contains("@")
        && !authViewModel.password.isEmpty
        && authViewModel.password.count >= 5
        && authViewModel.confirmPassword == authViewModel.password
    }
}
