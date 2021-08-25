//
//  LoginTextFieldView.swift
//  City
//
//  Created by Ivan Zakharov on 25/8/21.
//

import Foundation
import UIKit
import Framezilla

final class LoginTextFieldView: UIView {

    let textField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .roundedRect
        return textField
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "Arial", size: 12)
        label.isHidden = true
        return label
    }()
    init(placeholderText: String, errorText: String, secureText: Bool) {
        super.init(frame: .zero)
        label.text = errorText
        textField.placeholder = placeholderText
        textField.isSecureTextEntry = secureText
        add(textField, label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField.configureFrame { maker in
            maker.top()
                .left()
                .right()
                .height(40)
        }
        label.configureFrame { maker in
            maker.top(to: textField.nui_bottom, inset: 1)
            .left()
            .sizeToFit()
        }
}
    func update(viewModel: LoginTextFieldViewModel) {
        label.text = viewModel.errorText
        label.isHidden = viewModel.isHidden
        textField.backgroundColor = viewModel.color
    }
}
