//
//  City.swift
//  TableViewApp
//
//  Created by Ivan Zakharov on 14/12/20.
//

import Foundation
import UIKit
class City {
    var name: String
    var picture: UIImage
    init(name: String, picture: String) {
        self.name = name
        self.picture = UIImage(named: picture)!
    }
}
