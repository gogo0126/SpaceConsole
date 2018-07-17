//
//  UITextField+Extension.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/5.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
     func setUnderline() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
