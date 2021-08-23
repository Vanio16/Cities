//
//  StackView.swift
//  City
//
//  Created by Ivan Zakharov on 20/8/21.
//

import Foundation
import UIKit
import Framezilla

class CollectionViewCell: UICollectionViewCell {
    private struct Constants {
        static let imageSize: CGSize = .init(width: 100, height: 100)
        static let imageInsets: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
    }

    private let cityImage: UIImageView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        add(cityImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        cityImage.configureFrame { maker in
            maker.centerY()
                .centerX()
                .edges(insets: Constants.imageInsets)
        }
    }

    func refreshContent(_ city: City) {
        cityImage.image = city.picture
    }
}
