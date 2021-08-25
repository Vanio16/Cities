//
//  LoginPresenter.swift
//  City
//
//  Created by Ivan Zakharov on 24/8/21.
//

import Foundation

final class LoginPresenter {

    weak var view: LoginViewController?
    weak var output: LoginModuleOutput?

    init(state: LoginState) {

    }
}

extension LoginPresenter: LoginViewOutput {
//    func viewDidLoad() {
//        view?.cities = citiesService.getCity()
//    }
//
//    func showDetailScreen(_ city: City) {
//        output?.newCollectionDetailScreenShow(self, city: city)
//    }
}

extension LoginPresenter: LoginModuleInput {

}
