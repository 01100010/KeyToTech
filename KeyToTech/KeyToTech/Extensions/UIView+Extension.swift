//
//  UIView+Extension.swift
//  KeyToTech
//
//  Created by Oleksii on 7/13/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
}
