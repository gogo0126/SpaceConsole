//
//  UIButton+Extension.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/5.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setCycleBorder() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 7.0
//        self.layer.borderColor = UIColor.gray.cgColor
//        self.layer.borderWidth = 0.5
//        self.layer.masksToBounds = true
        
    }
}
