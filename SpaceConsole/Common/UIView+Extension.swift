//
//  UIView+Extension.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/9.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
