//
//  TableViewCell.swift
//  City
//
//  Created by Ivan Zakharov on 17/12/20.
//

import UIKit
import Framezilla

class TableViewCell: UITableViewCell {

    private struct Constants {
        static let imageSize: CGSize = .init(width: 100, height: 100)
        static let imageInsetLeft: CGFloat = 10
        static let textInsetRight: CGFloat = 10
        static let textInsetLeft: CGFloat = 10
    }

    private let titleLabel: UILabel = .init()
    private let cityImage: UIImageView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        add(titleLabel, cityImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        cityImage.configureFrame { maker in
            maker.centerY()
                .size(Constants.imageSize)
                .left(inset: Constants.imageInsetLeft)
        }

        titleLabel.configureFrame { maker in
            maker.centerY()
                .left(to: cityImage.nui_right, inset: Constants.textInsetLeft)
                .sizeToFit()
        }
    }

    func refreshContent(_ city: City) {
        cityImage.image = city.picture
        titleLabel.text = city.name
    }
}
