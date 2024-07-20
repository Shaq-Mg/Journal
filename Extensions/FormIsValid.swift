//
//  FormIsValid.swift
//  Journal
//
//  Created by Shaquille McGregor on 19/07/2024.
//

import Foundation

extension SignInView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.password.isEmpty
        && viewModel.password.count >= 5
    }
}

extension SignUpView {
    var formIsValid: Bool {
        return !viewModel.email.isEmpty
        && viewModel.email.contains("@")
        && !viewModel.name.isEmpty
        && viewModel.name.count >= 3
        && !viewModel.password.isEmpty
        && viewModel.password.count >= 5
        && viewModel.confirmPassword == viewModel.password
    }
}
