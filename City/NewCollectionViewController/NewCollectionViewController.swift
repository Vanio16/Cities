//
//  NewCollectionViewController.swift
//  City
//
//  Created by Ivan Zakharov on 23/8/21.
//

import Foundation
import UIKit
import Framezilla

protocol NewCollectionViewOutput {
    func viewDidLoad()
    func showDetailScreen(_ city: City)
}

final class NewCollectionViewController: UIViewController {

    private struct Constants {
        static let insetBetweenItems: CGFloat = 16
        static let insetBetweenRows: CGFloat = 16
    }

    private let output: NewCollectionViewOutput
    var cities: [City] = []

    // MARK: - Subview

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)

    // MARK: - Lifecycle

    init(output: NewCollectionViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.backgroundColor = .clear
        view.backgroundColor = .blue
    }

// MARK: - Layout

    override func viewDidLayoutSubviews() {
        collectionView.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top)
                .bottom(to: view.nui_safeArea.bottom)
                .left()
                .right()
        }
    }
}

// MARK: - NewCollectionViewController

extension NewCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell
        cell?.refreshContent(cities[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.showDetailScreen(cities[indexPath.item])
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - Constants.insetBetweenItems * 2 -
                        (collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right)) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.insetBetweenRows
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.insetBetweenItems
    }
}
