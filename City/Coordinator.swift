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
    let navigationController: UINavigationController
    let mainViewController = MainViewController()
    let detailViewController = DetailViewController()
    
    init(window: UIWindow) {
        self.window = window
        navigationController = .init(rootViewController: mainViewController)
    }
    
    func start() {
        mainViewController.output = self
        detailViewController.output = self
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showDetailScreen(_ image: UIImage, _ name: String) {
        detailViewController.commonInit(image, title: name)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func showMainScreen() {
        navigationController.popViewController(animated: true)
    }
}
