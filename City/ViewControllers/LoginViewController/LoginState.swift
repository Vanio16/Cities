//
//  LoginState.swift
//  City
//
//  Created by Ivan Zakharov on 24/8/21.
//

import Foundation
import UIKit

final class LoginState {
    var isHidePasswordButtonTap = false
    private let imageEye = UIImage(systemName: "eye")!
    private let imageClosedEye = UIImage(systemName: "eye.slash")!
    var passwordButtonImage: UIImage {
        if isHidePasswordButtonTap {
            return imageEye
        }
        else {
            return imageClosedEye
        }
    }
}
