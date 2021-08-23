//
//  CitiesService.swift
//  City
//
//  Created by Ivan Zakharov on 23/8/21.
//

import Foundation
import UIKit

final class CitiesService {
    static var shared: CitiesService = {
        let instance = CitiesService()
        return instance
    }()

    private var cities = [City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk"),
                  City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk"),
                  City(name: "Omsk", picture: "omsk"),
                  City(name: "Moscow", picture: "moscow"),
                  City(name: "St. Petersburg", picture: "piter"),
                  City(name: "Novosibirsk", picture: "novosib"),
                  City(name: "Samara", picture: "samara"),
                  City(name: "Irkutsk", picture: "irkutsk")]

    func getCity () -> [City] {
        return cities
    }
}
