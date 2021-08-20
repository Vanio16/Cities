//
//  TabBarItem.swift
//  City
//
//  Created by Ivan Zakharov on 20/8/21.
//

import Foundation
import UIKit

class TabBarItem {
    var image: UIImage?
    var title: String
    init(title: String, imageName: String) {
        self.title = title
        self.image = UIImage(systemName: imageName)
    }
}
