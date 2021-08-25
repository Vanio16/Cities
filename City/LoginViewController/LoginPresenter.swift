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

    init(state: LoginState) {

    }
}

extension LoginPresenter: LoginViewOutput {
    func loadDataInPresenter(textFirstName: String, textLastName: String, textEmail: String, textPassword: String) {
        if textFirstName.count == 0 {
            view?.firstNameLoginTextViewModel.isHidden = false
            view?.firstNameLoginTextViewModel.color = .systemPink
        }
        else {
            view?.firstNameLoginTextViewModel.color = .green
            view?.firstNameLoginTextViewModel.isHidden = true
        }

        if textLastName.count == 0 {
            view?.lastNameLoginTextViewModel.color = .systemPink
            view?.lastNameLoginTextViewModel.isHidden = false
        }
        else {
            view?.lastNameLoginTextViewModel.color = .green
            view?.lastNameLoginTextViewModel.isHidden = true
        }
        if textEmail.count == 0 {
            view?.emailLoginTextViewModel.color = .systemPink
            view?.emailLoginTextViewModel.errorText = "Это поле не может быть пустым"
            view?.emailLoginTextViewModel.isHidden = false
        }
        else if textEmail.count != 0 && !isValidEmail(textEmail) {
            view?.emailLoginTextViewModel.color = .systemPink
            view?.emailLoginTextViewModel.errorText = "Введите правильный e-mail"
            view?.emailLoginTextViewModel.isHidden = false
        }
        else {
            view?.emailLoginTextViewModel.color = .green
            view?.emailLoginTextViewModel.isHidden = true
        }

        if textPassword.count < 6 {
            view?.passwordLoginTextViewModel.color = .systemPink
            view?.passwordLoginTextViewModel.isHidden = false
        }
        else {
            view?.passwordLoginTextViewModel.color = .green
            view?.passwordLoginTextViewModel.isHidden = true
        }
        view?.update()
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

extension LoginPresenter: LoginModuleInput {

}
