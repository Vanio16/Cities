//
//  CollectonViewController.swift
//  City
//
//  Created by Ivan Zakharov on 20/8/21.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    private struct Constants {
        static let insetBetweenItems: CGFloat = 16
        static let insetBetweenRows: CGFloat = 16
    }
    var output: MainViewControllerOutput?
    var citiesService: CitiesService = CitiesService.shared
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .yellow
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .yellow
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
    }

    override func viewDidLayoutSubviews() {
        collectionView.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top)
                .bottom(to: view.nui_safeArea.bottom)
                .left()
                .right()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        citiesService.getCity().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell
        cell?.refreshContent(citiesService.getCity()[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.showDetailScreen(citiesService.getCity()[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.width - Constants.insetBetweenItems * 2 - 16 * 2) / 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.insetBetweenRows
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.insetBetweenItems
    }
}
