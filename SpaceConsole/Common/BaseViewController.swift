//
//  BaseViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/6/28.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    
    func setRightItemSearch() {
        let img = UIImage(named: "ic_search")
        let searchItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: Selector("searchButtonOnClicked:"))
        self.navigationItem.rightBarButtonItem = searchItem
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
