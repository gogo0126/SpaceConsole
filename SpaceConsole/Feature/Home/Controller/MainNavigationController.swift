//
//  MianNavigationController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/2.
//  Copyright © 2018年 SpaceAdvisor. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    static var defaultNavigation: MainNavigationController {
        get {
            let vc = MainViewController()
            let sharedInstance = MainNavigationController(rootViewController: vc)
            return sharedInstance
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
