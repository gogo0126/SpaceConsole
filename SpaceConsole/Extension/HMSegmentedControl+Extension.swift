//
//  HMSegmentedControl+Extension.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/23.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import Foundation
import HMSegmentedControl

extension HMSegmentedControl {
    func addDefaultUnderline() {
        let underline = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 3, width: UIScreen.main.bounds.size.width, height: 3))
        underline.backgroundColor = UIColor.spaGreyish
        self.insertSubview(underline, at: 0)
    }
}
