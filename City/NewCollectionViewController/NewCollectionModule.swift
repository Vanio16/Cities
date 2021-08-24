//
//  NewCollectionModule.swift
//  City
//
//  Created by Ivan Zakharov on 23/8/21.
//

import Foundation

protocol NewCollectionModuleInput: AnyObject {

}

protocol NewCollectionModuleOutput: AnyObject {

    func newCollectionDetailScreenShow(_ moduleInput: NewCollectionModuleInput, city: City)
}

final class NewCollectionModule {

    var input: NewCollectionModuleInput {
        return presenter
    }
    var output: NewCollectionModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: NewCollectionViewController
    private let presenter: NewCollectionPresenter

    init(state: NewCollectionState = .init()) {
        let presenter = NewCollectionPresenter(state: state)
        let viewController = NewCollectionViewController(output: presenter)
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
