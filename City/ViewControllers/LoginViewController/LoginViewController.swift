//
//  LoginViewController.swift
//  City
//
//  Created by Ivan Zakharov on 24/8/21.
//

import Foundation
import UIKit
import Framezilla

protocol LoginViewOutput {
    func sendData(firstName: LoginTextFieldViewModel,
                  lastName: LoginTextFieldViewModel,
                  email: LoginTextFieldViewModel,
                  password: LoginTextFieldViewModel,
                  username: LoginTextFieldViewModel,
                  address: LoginTextFieldViewModel,
                  phoneNumber: LoginTextFieldViewModel)
    func togglePasswordSecure()
}

final class LoginViewController: UIViewController {

    private struct Constants {
        static let firstNameFieldInsetTop: CGFloat = 16
        static let firstNameFieldInsetRight: CGFloat = 16
        static let firstNameFieldInsetLeft: CGFloat = 16
        static let firstNameFieldHeight: CGFloat = 50
        static let lastNameFieldHeight: CGFloat = 50
        static let lastNameFieldInsetTop: CGFloat = 20
        static let lastNameFieldInsetRight: CGFloat = 16
        static let lastNameFieldInsetLeft: CGFloat = 16
        static let emailFieldHeight: CGFloat = 50
        static let emailFieldInsetTop: CGFloat = 20
        static let emailFieldInsetRight: CGFloat = 16
        static let emailFieldInsetLeft: CGFloat = 16
        static let passwordFieldHeight: CGFloat = 50
        static let passwordFieldInsetTop: CGFloat = 20
        static let passwordFieldInsetRight: CGFloat = 16
        static let passwordFieldInsetLeft: CGFloat = 16
        static let hidePasswordButtonInsetTop: CGFloat = 1
        static let hidePasswordButtonSize: CGSize = .init(width: 30, height: 30)
        static let hidePasswordButtonInsetRight: CGFloat = 16
        static let sendButtonInsetTop: CGFloat = 30
        static let usernameFieldInsetTop: CGFloat = 35
        static let usernameFieldInsetRight: CGFloat = 16
        static let usernameFieldInsetLeft: CGFloat = 16
        static let usernameFieldHeight: CGFloat = 50
        static let addressFieldInsetTop: CGFloat = 20
        static let addressFieldInsetRight: CGFloat = 16
        static let addressFieldInsetLeft: CGFloat = 16
        static let addressFieldHeight: CGFloat = 50
        static let phoneNumberFieldInsetTop: CGFloat = 20
        static let phoneNumberFieldInsetRight: CGFloat = 16
        static let phoneNumberFieldInsetLeft: CGFloat = 16
        static let phoneNumberFieldHeight: CGFloat = 50
    }
    var oldPhoneFieldText: String = ""
    var output: LoginViewOutput
    var firstNameLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                     color: .red,
                                                                     errorText: "Это поле не может быть пустым",
                                                                     text: "")
    var lastNameLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                    color: .red,
                                                                    errorText: "Это поле не может быть пустым",
                                                                    text: "")
    var emailLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                 color: .red,
                                                                 errorText: "Это поле не может быть пустым",
                                                                 text: "")
    var passwordLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                    color: .red,
                                                                    errorText: "Пароль не может быть короче 6 символов",
                                                                    text: "")
    var usernameLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                    color: .red,
                                                                    errorText: "Это поле не может быть пустым",
                                                                    text: "")
    var addressLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                   color: .red,
                                                                   errorText: "Это поле не может быть пустым",
                                                                   text: "")
    var phoneNumberLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                       color: .red,
                                                                       errorText: "Это поле не может быть пустым",
                                                                       text: "")

    // MARK: - Subview

    private lazy var firstNameField = LoginTextFieldView(placeholderText: "First name*",
                                                         errorText: firstNameLoginTextViewModel.errorText,
                                                         isTextSecure: false)
    private lazy var lastNameField = LoginTextFieldView(placeholderText: "Last name*",
                                                        errorText: lastNameLoginTextViewModel.errorText,
                                                        isTextSecure: false)
    private lazy var emailField = LoginTextFieldView(placeholderText: "E-mail*",
                                                     errorText: emailLoginTextViewModel.errorText,
                                                     isTextSecure: false)
    lazy var passwordField = LoginTextFieldView(placeholderText: "Password*",
                                                errorText: passwordLoginTextViewModel.errorText,
                                                isTextSecure: true)
    private lazy var usernameField = LoginTextFieldView(placeholderText: "Username*",
                                                        errorText: usernameLoginTextViewModel.errorText,
                                                        isTextSecure: false)
    private lazy var addressField = LoginTextFieldView(placeholderText: "Home address*",
                                                       errorText: addressLoginTextViewModel.errorText,
                                                       isTextSecure: false)
    private lazy var phoneNumberField = LoginTextFieldView(placeholderText: "Phone number*",
                                                           errorText: passwordLoginTextViewModel.errorText,
                                                           isTextSecure: false)

    let hidePasswordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye")
        button.tintColor = .black
        button.addTarget(self, action: #selector(tapHidePasswordButton), for: .touchUpInside)
        button.setImage(image, for: .normal)
        return button
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(sendUserInfo), for: .touchUpInside)
        button.setTitle("Отправить", for: .normal)
        return button
    }()

    // MARK: - Lifecycle

    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(firstNameField,
                 lastNameField,
                 emailField, passwordField,
                 hidePasswordButton,
                 sendButton,
                 addressField,
                 usernameField,
                 phoneNumberField)
        view.backgroundColor = .orange
        phoneNumberField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        firstNameField.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top, inset: Constants.firstNameFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.firstNameFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.firstNameFieldInsetRight)
                .height(Constants.firstNameFieldHeight)
        }

        lastNameField.configureFrame { maker in
            maker.top(to: firstNameField.nui_bottom, inset: Constants.lastNameFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.lastNameFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.lastNameFieldInsetRight)
                .height(Constants.lastNameFieldHeight)
        }

        emailField.configureFrame { maker in
            maker.top(to: lastNameField.nui_bottom, inset: Constants.emailFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.emailFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.emailFieldInsetRight)
                .height(Constants.emailFieldHeight)
        }

        passwordField.configureFrame { maker in
            maker.top(to: emailField.nui_bottom, inset: Constants.passwordFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.passwordFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.passwordFieldInsetRight)
                .height(Constants.passwordFieldHeight)
        }

        hidePasswordButton.configureFrame { maker in
            maker.size(Constants.hidePasswordButtonSize)
                .top(to: passwordField.nui_bottom, inset: Constants.hidePasswordButtonInsetTop)
                .right(to: view.nui_safeArea.right, inset: Constants.hidePasswordButtonInsetRight)
        }

        usernameField.configureFrame { maker in
            maker.top(to: passwordField.nui_bottom, inset: Constants.usernameFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.usernameFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.usernameFieldInsetRight)
                .height(Constants.usernameFieldHeight)
        }

        addressField.configureFrame { maker in
            maker.top(to: usernameField.nui_bottom, inset: Constants.addressFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.addressFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.addressFieldInsetRight)
                .height(Constants.addressFieldHeight)
        }

        phoneNumberField.configureFrame { maker in
            maker.top(to: addressField.nui_bottom, inset: Constants.phoneNumberFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.phoneNumberFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.phoneNumberFieldInsetRight)
                .height(Constants.phoneNumberFieldHeight)
        }

        sendButton.configureFrame { maker in
            maker.sizeToFit()
                .centerX()
                .top(to: phoneNumberField.nui_bottom, inset: Constants.sendButtonInsetTop)
        }
    }

    // MARK: - Actions

    @objc private func tapHidePasswordButton() {
        output.togglePasswordSecure()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        let firstSymbol = text.first
        let lastSymbol = String(text.suffix(1))
        if text.count == 1 {
            let phoneNumRegEx = "[0-9+]"
            let phoneNumPred = NSPredicate(format: "SELF MATCHES %@", phoneNumRegEx)
            if !phoneNumPred.evaluate(with: text) {
                textField.text = oldPhoneFieldText
                return
            }
        }
        if text.count > 1 {
            let phoneNumRegEx = "[0-9]"
            let phoneNumPred = NSPredicate(format: "SELF MATCHES %@", phoneNumRegEx)
            if !phoneNumPred.evaluate(with: lastSymbol) {
                textField.text = oldPhoneFieldText
                return
            }
        }
        if firstSymbol == "+" && text.count > 12 {
            textField.text = oldPhoneFieldText
            return
        }
        if firstSymbol != "+" && text.count > 11 {
            textField.text = oldPhoneFieldText
            return
        }
        oldPhoneFieldText = text
    }

    @objc private func sendUserInfo() {
        firstNameLoginTextViewModel.text = firstNameField.textField.text ?? ""
        lastNameLoginTextViewModel.text = lastNameField.textField.text ?? ""
        emailLoginTextViewModel.text = emailField.textField.text ?? ""
        passwordLoginTextViewModel.text = passwordField.textField.text ?? ""
        usernameLoginTextViewModel.text = usernameField.textField.text ?? ""
        addressLoginTextViewModel.text = addressField.textField.text ?? ""
        phoneNumberLoginTextViewModel.text = phoneNumberField.textField.text ?? ""

        output.sendData(firstName: firstNameLoginTextViewModel,
                        lastName: lastNameLoginTextViewModel,
                        email: emailLoginTextViewModel,
                        password: passwordLoginTextViewModel,
                        username: usernameLoginTextViewModel,
                        address: addressLoginTextViewModel,
                        phoneNumber: phoneNumberLoginTextViewModel)
        view.endEditing(true)
    }
    func update() {
        firstNameField.update(viewModel: firstNameLoginTextViewModel)
        lastNameField.update(viewModel: lastNameLoginTextViewModel)
        emailField.update(viewModel: emailLoginTextViewModel)
        passwordField.update(viewModel: passwordLoginTextViewModel)
        usernameField.update(viewModel: usernameLoginTextViewModel)
        addressField.update(viewModel: addressLoginTextViewModel)
        phoneNumberField.update(viewModel: phoneNumberLoginTextViewModel)
    }
}
