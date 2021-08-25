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
    //  func viewDidLoad()
    //    func showDetailScreen(_ city: City)
}

final class LoginViewController: UIViewController {

    private struct Constants {
        static let firstNameTextFieldHeight: CGFloat = 40
        static let firstNameTextFieldInsetTop: CGFloat = 16
        static let firstNameTextFieldInsetRight: CGFloat = 16
        static let firstNameTextFieldInsetLeft: CGFloat = 16
        static let lastNameTextFieldHeight: CGFloat = 40
        static let lastNameTextFieldInsetTop: CGFloat = 30
        static let lastNameTextFieldInsetRight: CGFloat = 16
        static let lastNameTextFieldInsetLeft: CGFloat = 16
        static let emailTextFieldHeight: CGFloat = 40
        static let emailTextFieldInsetTop: CGFloat = 30
        static let emailTextFieldInsetRight: CGFloat = 16
        static let emailTextFieldInsetLeft: CGFloat = 16
        static let passwordTextFieldHeight: CGFloat = 40
        static let passwordTextFieldInsetTop: CGFloat = 30
        static let passwordTextFieldInsetRight: CGFloat = 16
        static let passwordTextFieldInsetLeft: CGFloat = 16
        static let hidePasswordButtonInsetTop: CGFloat = 1
        static let hidePasswordButtonSize: CGSize = .init(width: 30, height: 30)
        static let hidePasswordButtonInsetRight: CGFloat = 16
        static let sendButtonInsetTop: CGFloat = 30
        static let firstNameErrorTextInsetTop = 1
        static let firstNameErrorTextInsetLeft = 16
        static let lastNameErrorTextInsetTop = 1
        static let lastNameErrorTextInsetLeft = 16
        static let emailErrorTextInsetTop = 1
        static let emailErrorTextInsetLeft = 16
        static let passwordErrorTextInsetTop = 1
        static let passwordErrorTextInsetLeft = 16
    }

    var output: LoginViewOutput

    // MARK: - Subview

    private let firstNameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Это поле не может быть пустым"
        label.font = UIFont(name: "Arial", size: 12)
        label.isHidden = true
        return label
    }()
    private let lastNameErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Это поле не может быть пустым"
        label.font = UIFont(name: "Arial", size: 12)
        label.isHidden = true
        return label
    }()
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Это поле не может быть пустым"
        label.font = UIFont(name: "Arial", size: 12)
        label.isHidden = true
        return label
    }()
    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = "Пароль не может быть короче 6 символов"
        label.font = UIFont(name: "Arial", size: 12)
        label.isHidden = true
        return label
    }()
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "First name*"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Last name*"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "E-mail*"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Password*"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let hidePasswordButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "eye.slash")
        button.tintColor = .black   //     button.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
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
        // output.viewDidLoad()
        view.add(firstNameTextField, lastNameTextField, emailTextField, passwordTextField, hidePasswordButton, sendButton, firstNameErrorLabel, lastNameErrorLabel, emailErrorLabel, passwordErrorLabel)
        view.backgroundColor = .orange
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        firstNameTextField.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top, inset: Constants.firstNameTextFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.firstNameTextFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.firstNameTextFieldInsetRight)
                .height(Constants.firstNameTextFieldHeight)
        }

        lastNameTextField.configureFrame { maker in
            maker.top(to: firstNameTextField.nui_bottom, inset: Constants.lastNameTextFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.lastNameTextFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.lastNameTextFieldInsetRight)
                .height(Constants.lastNameTextFieldHeight)
        }

        emailTextField.configureFrame { maker in
            maker.top(to: lastNameTextField.nui_bottom, inset: Constants.emailTextFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.emailTextFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.emailTextFieldInsetRight)
                .height(Constants.emailTextFieldHeight)
        }

        passwordTextField.configureFrame { maker in
            maker.top(to: emailTextField.nui_bottom, inset: Constants.passwordTextFieldInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.passwordTextFieldInsetLeft)
                .right(to: view.nui_safeArea.right, inset: Constants.passwordTextFieldInsetRight)
                .height(Constants.passwordTextFieldHeight)
        }

        firstNameErrorLabel.configureFrame { maker in
            maker.top(to: firstNameTextField.nui_bottom, inset: Constants.firstNameErrorTextInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.firstNameErrorTextInsetLeft)
                .sizeToFit()
        }

        lastNameErrorLabel.configureFrame { maker in
            maker.top(to: lastNameTextField.nui_bottom, inset: Constants.lastNameErrorTextInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.lastNameErrorTextInsetLeft)
                .sizeToFit()
        }

        emailErrorLabel.configureFrame { maker in
            maker.top(to: emailTextField.nui_bottom, inset: Constants.emailErrorTextInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.emailErrorTextInsetLeft)
                .sizeToFit()
        }

        passwordErrorLabel.configureFrame { maker in
            maker.top(to: passwordTextField.nui_bottom, inset: Constants.passwordErrorTextInsetTop)
                .left(to: view.nui_safeArea.left, inset: Constants.passwordErrorTextInsetLeft)
                .sizeToFit()
        }

        hidePasswordButton.configureFrame { maker in
            maker.size(Constants.hidePasswordButtonSize)
                .top(to: passwordTextField.nui_bottom, inset: Constants.hidePasswordButtonInsetTop)
                .right(to: view.nui_safeArea.right, inset: Constants.hidePasswordButtonInsetRight)
        }

        sendButton.configureFrame { maker in
            maker.sizeToFit()
                .centerX()
                .top(to: passwordTextField.nui_bottom, inset: Constants.sendButtonInsetTop)
        }
    }

    // MARK: - Actions

    @objc private func sendUserInfo() {
        if firstNameTextField.text?.count == 0 {
            firstNameTextField.backgroundColor = .systemPink
            firstNameErrorLabel.isHidden = false
        }
        else {
            firstNameTextField.backgroundColor = .green
            firstNameErrorLabel.isHidden = true
        }

        if lastNameTextField.text?.count == 0 {
            lastNameTextField.backgroundColor = .systemPink
            lastNameErrorLabel.isHidden = false
        }
        else {
            lastNameTextField.backgroundColor = .green
            lastNameErrorLabel.isHidden = true
        }

        if emailTextField.text?.count == 0 {
            emailTextField.backgroundColor = .systemPink
            emailErrorLabel.isHidden = false
        }
        else {
            emailTextField.backgroundColor = .green
            emailErrorLabel.isHidden = true
        }

        if passwordTextField.text?.count ?? 0 < 6 {
            passwordTextField.backgroundColor = .systemPink
            passwordErrorLabel.isHidden = false
        }
        else {
            passwordTextField.backgroundColor = .green
            passwordErrorLabel.isHidden = true
        }
        view.endEditing(true)
    }
}
