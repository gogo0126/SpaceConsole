//
//  FirstViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/6/27.
//  Copyright © 2018年 SpaceAdvisor. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ApiManager.sharedManager.fetchParks(offset: 0, limit: 10) {
            (taipeiParkResponse: TaipeiApiResponse?, error: String?) in
            if let error = error {
                print(error)
            } else {
                if let taipeiParkResponse = taipeiParkResponse {
                    print(taipeiParkResponse)
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

