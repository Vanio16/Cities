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
        static let imageInsetLeft: CGFloat = 4
        static let imageInsetRight: CGFloat = 4
        static let imageInsetTop: CGFloat = 4
        static let imageInsetBot: CGFloat = 4
        static let textInsetTop: CGFloat = 4
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
                .left(inset: Constants.imageInsetLeft)
                .right(inset: Constants.imageInsetRight)
                .top(inset: Constants.imageInsetTop)
                .bottom(inset: Constants.imageInsetBot)
        }
    }

    func refreshContent(_ city: City) {
        cityImage.image = city.picture
    }
}
