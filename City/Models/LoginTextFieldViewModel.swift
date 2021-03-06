//
//  LoginTextFieldViewModel.swift
//  City
//
//  Created by Ivan Zakharov on 25/8/21.
//

import Foundation
import UIKit

final class LoginTextFieldViewModel {
    var isHidden: Bool
    var color: UIColor
    var errorText: String
    var text: String
    init(isHidden: Bool, color: UIColor, errorText: String, text: String) {
        self.isHidden = isHidden
        self.color = color
        self.errorText = errorText
        self.text = text
    }
}
