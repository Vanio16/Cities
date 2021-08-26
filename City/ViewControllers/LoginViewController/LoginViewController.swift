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
    func sendData(textFirstName: String, textLastName: String, textEmail: String, textPassword: String)
    func togglePasswordSecure()
}

final class LoginViewController: UIViewController {

    private struct Constants {
        static let firstNameFieldInsetTop: CGFloat = 16
        static let firstNameFieldInsetRight: CGFloat = 16
        static let firstNameFieldInsetLeft: CGFloat = 16
        static let firstNameFieldHight: CGFloat = 50
        static let lastNameFieldHeight: CGFloat = 50
        static let lastNameFieldInsetTop: CGFloat = 30
        static let lastNameFieldInsetRight: CGFloat = 16
        static let lastNameFieldInsetLeft: CGFloat = 16
        static let emailFieldHeight: CGFloat = 50
        static let emailFieldInsetTop: CGFloat = 30
        static let emailFieldInsetRight: CGFloat = 16
        static let emailFieldInsetLeft: CGFloat = 16
        static let passwordFieldHeight: CGFloat = 50
        static let passwordFieldInsetTop: CGFloat = 30
        static let passwordFieldInsetRight: CGFloat = 16
        static let passwordFieldInsetLeft: CGFloat = 16
        static let hidePasswordButtonInsetTop: CGFloat = 1
        static let hidePasswordButtonSize: CGSize = .init(width: 30, height: 30)
        static let hidePasswordButtonInsetRight: CGFloat = 16
        static let sendButtonInsetTop: CGFloat = 30
    }
    var output: LoginViewOutput
    var firstNameLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                     color: .red,
                                                                     errorText: "Это поле не может быть пустым")
    var lastNameLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                    color: .red,
                                                                    errorText: "Это поле не может быть пустым")
    var emailLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                 color: .red,
                                                                 errorText: "Это поле не может быть пустым")
    var passwordLoginTextViewModel: LoginTextFieldViewModel = .init(isHidden: false,
                                                                    color: .red,
                                                                    errorText: "Пароль не может быть короче 6 символов")

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
        view.add(firstNameField, lastNameField, emailField, passwordField, hidePasswordButton, sendButton)
        view.backgroundColor = .orange
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        firstNameField.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top, inset: Constants.firstNameFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.firstNameFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.firstNameFieldInsetRight)
                .height(Constants.firstNameFieldHight)
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

        sendButton.configureFrame { maker in
            maker.sizeToFit()
                .centerX()
                .top(to: passwordField.nui_bottom, inset: Constants.sendButtonInsetTop)
        }
    }

    // MARK: - Actions

    @objc private func tapHidePasswordButton() {
        output.togglePasswordSecure()
    }

    @objc private func sendUserInfo() {
        output.sendData(textFirstName: firstNameField.textField.text ?? "",
                        textLastName: lastNameField.textField.text ?? "",
                        textEmail: emailField.textField.text ?? "",
                        textPassword: passwordField.textField.text ?? "")
        view.endEditing(true)
    }
    func update() {
        firstNameField.update(viewModel: firstNameLoginTextViewModel)
        lastNameField.update(viewModel: lastNameLoginTextViewModel)
        emailField.update(viewModel: emailLoginTextViewModel)
        passwordField.update(viewModel: passwordLoginTextViewModel)
    }
}
