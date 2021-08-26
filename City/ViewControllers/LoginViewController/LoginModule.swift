//
//  LoginModule.swift
//  City
//
//  Created by Ivan Zakharov on 24/8/21.
//

import Foundation

protocol LoginModuleInput: AnyObject {

}

protocol LoginModuleOutput: AnyObject {

}

final class LoginModule {

    var input: LoginModuleInput {
        return presenter
    }
    var output: LoginModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: LoginViewController
    private let presenter: LoginPresenter

    init(state: LoginState = .init()) {
        let presenter = LoginPresenter(state: state)
        let viewController = LoginViewController(output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
