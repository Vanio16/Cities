//
//  Coordinator.swift
//  NewButtonApp
//
//  Created by Ivan Zakharov on 19/8/21.
//

import Foundation
import UIKit

final class Coordinator: MainViewControllerOutput, DetailViewControllerOutput {

    let window: UIWindow
    var navigationController: UINavigationController
    let tabBarController = TabBarController()
    let mainViewController = MainViewController()
    let detailViewController = DetailViewController()
    let collectionViewController = CollectionViewController()
    var tabBarItems = [TabBarItem(title: "Таблица", imageName: "rectangle.grid.1x2.fill"),
    TabBarItem(title: "Коллекция", imageName: "square.grid.2x2.fill")]

    init(window: UIWindow) {
        self.window = window
        tabBarController.setViewControllers([mainViewController, collectionViewController], animated: true)
        let items = tabBarController.tabBar.items
        for item in 0..<tabBarItems.count {
            items?[item].image = tabBarItems[item].image
            items?[item].title = tabBarItems[item].title
        }
        navigationController = .init(rootViewController: tabBarController)
    }

    func start() {
        mainViewController.output = self
        detailViewController.output = self
        collectionViewController.output = self
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
