//
//  MainCoordinator.swift
//  City
//
//  Created by Ivan Zakharov on 19/8/21.
//

import Foundation
import UIKit

final class MainCoordinator: MainViewControllerOutput, DetailViewControllerOutput, LoginModuleOutput {

    let window: UIWindow
    var navigationController: UINavigationController
    let tabBarController = TabBarController()
    let mainViewController = MainViewController()
    let detailViewController = DetailViewController()
    var tabBarItems = [TabBarItem(title: "Таблица", imageName: "rectangle.grid.1x2.fill"),
    TabBarItem(title: "Коллекция", imageName: "square.grid.2x2.fill"),
    TabBarItem(title: "Вход", imageName: "person.fill")]
    let newCollectionModule: NewCollectionModule = .init()
    let loginModule: LoginModule = .init()

    init(window: UIWindow) {
        self.window = window
        tabBarController.setViewControllers([mainViewController, newCollectionModule.viewController,
                                             loginModule.viewController], animated: true)
        let items = tabBarController.tabBar.items
        for index in 0..<tabBarItems.count {
            items?[index].image = tabBarItems[index].image
            items?[index].title = tabBarItems[index].title
        }
        navigationController = .init(rootViewController: tabBarController)
        navigationController.navigationBar.isHidden = true
    }

    func start() {
        mainViewController.output = self
        detailViewController.output = self
        newCollectionModule.output = self
        loginModule.output = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func showDetailScreen(_ city: City) {
        detailViewController.refreshContent(city)
        navigationController.pushViewController(detailViewController, animated: true)
    }

    func showMainScreen() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: NewCollectionModuleOutput {
    func newCollectionDetailScreenShow(_ moduleInput: NewCollectionModuleInput, city: City) {
        detailViewController.refreshContent(city)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
