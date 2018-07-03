//
//  SPALoginNavigationController.swift
//  SpaceHR
//
//  Created by Jerry on 2018/6/7.
//  Copyright © 2018年 SpaceAdvisor. All rights reserved.
//

import UIKit

class LoginNavigationController: UINavigationController {

    static var defaultNavigation: LoginNavigationController {
        get {
            let vc = LoginViewController()
            let sharedInstance = LoginNavigationController(rootViewController: vc)
            return sharedInstance
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
