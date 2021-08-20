//
//  DetailViewController.swift
//  City
//
//  Created by Ivan Zakharov on 19/8/21.
//

import Foundation
import UIKit
import Framezilla

protocol DetailViewControllerOutput {
    func showMainScreen()
}

class DetailViewController: UIViewController {

    private struct Constants {
        static let nameLabelInsetTop: CGFloat = 20
        static let backButtonInsetTop: CGFloat = 20
    }

    var output: DetailViewControllerOutput?
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let pictureImageView: UIImageView = .init()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeScreenButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.add(nameLabel, backButton, pictureImageView)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pictureImageView.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top)
                .left(to: view.nui_safeArea.left)
                .right(to: view.nui_safeArea.right)
                .bottom(to: view.nui_centerY)
        }

        nameLabel.configureFrame { maker in
            maker.centerX()
                .top(to: pictureImageView.nui_bottom, inset: Constants.nameLabelInsetTop)
                .left(to: view.nui_safeArea.left)
                .right(to: view.nui_safeArea.right)
                .heightToFit()

        }

        backButton.configureFrame { maker in
            maker.sizeToFit()
                .centerX()
                .top(to: nameLabel.nui_bottom, inset: Constants.backButtonInsetTop)
        }
    }

    func refreshContent(_ city: City) {
        pictureImageView.image = city.picture
        nameLabel.text = city.name
    }

    @objc private func closeScreenButton() {
        output?.showMainScreen()
    }
}
