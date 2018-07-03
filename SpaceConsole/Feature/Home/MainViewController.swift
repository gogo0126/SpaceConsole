//
//  MainViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/2.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftBarItem()
    }

    func setupLeftBarItem() {
        let leftItem = UIBarButtonItem(title: "=", style: .plain, target: self
            , action:nil)
        
        leftItem.rx
            .tap
            .subscribe(onNext: {
                ViewManager.sharedManager.openLeftSideMenu()
            })
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func openLeftMenu() {
        ViewManager.sharedManager.openLeftSideMenu()
    }

}
