//
//  UIVIew+Sugar.swift
//  NewButtonApp
//
//  Created by Ivan Zakharov on 19/8/21.
//

import UIKit

extension UIView {
    func add(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
