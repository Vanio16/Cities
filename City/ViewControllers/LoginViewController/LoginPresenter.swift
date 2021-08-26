//
//  LoginPresenter.swift
//  City
//
//  Created by Ivan Zakharov on 24/8/21.
//

import Foundation
import UIKit

final class LoginPresenter {

    weak var view: LoginViewController?
    weak var output: LoginModuleOutput?
    var state: LoginState
    init(state: LoginState) {
        self.state = state
    }
}

extension LoginPresenter: LoginViewOutput {
    func togglePasswordSecure() {
        state.isHidePasswordButtonTap.toggle()
        view?.passwordField.textField.isSecureTextEntry = state.isHidePasswordButtonTap
        view?.hidePasswordButton.setImage(state.passwordButtonImage, for: .normal)
    }

    func sendData(firstName: LoginTextFieldViewModel,
                  lastName: LoginTextFieldViewModel,
                  email: LoginTextFieldViewModel,
                  password: LoginTextFieldViewModel,
                  username: LoginTextFieldViewModel,
                  address: LoginTextFieldViewModel,
                  phoneNumber: LoginTextFieldViewModel) {
        checkFieldViewModel(firstName, minTextCount: 0)
        checkFieldViewModel(lastName, minTextCount: 0)
        checkFieldViewModel(password, minTextCount: 5)
        checkFieldViewModel(username, minTextCount: 0)
        checkFieldViewModel(address, minTextCount: 0)
        checkFieldViewModel(phoneNumber, minTextCount: 0)

        if email.text.count == 0 {
            email.color = .systemPink
            email.errorText = "Это поле не может быть пустым"
            email.isHidden = false
        }
        else if email.text.count != 0 && !isValidEmail(email.text) {
            email.color = .systemPink
            email.errorText = "Введите правильный e-mail"
            email.isHidden = false
        }
        else {
            email.color = .green
            email.isHidden = true
        }
        view?.update()
    }
    private func checkFieldViewModel(_ viewModel: LoginTextFieldViewModel, minTextCount: Int) {
        if viewModel.text.count > minTextCount {
            viewModel.color = .green
            viewModel.isHidden = true
        }
        else {
            viewModel.isHidden = false
            viewModel.color = .systemPink
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension LoginPresenter: LoginModuleInput {

}
