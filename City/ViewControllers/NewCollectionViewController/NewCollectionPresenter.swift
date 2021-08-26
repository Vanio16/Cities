//
//  NewCollectionPresenter.swift
//  City
//
//  Created by Ivan Zakharov on 23/8/21.
//

import Foundation

final class NewCollectionPresenter {

    weak var view: NewCollectionViewController?
    weak var output: NewCollectionModuleOutput?
    var citiesService: CitiesService = CitiesService.shared
    init(state: NewCollectionState) {

    }
}

extension NewCollectionPresenter: NewCollectionViewOutput {
    func viewDidLoad() {
        view?.cities = citiesService.getCity()
    }

    func showDetailScreen(_ city: City) {
        output?.newCollectionDetailScreenShow(self, city: city)
    }
}

extension NewCollectionPresenter: NewCollectionModuleInput {

}
