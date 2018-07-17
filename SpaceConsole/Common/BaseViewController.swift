//
//  BaseViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/6/28.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLeftBarItem()
        setupRightBarItem()

        
    }

    func setupLeftBarItem() {
        let leftItem = UIBarButtonItem(image: UIImage(named:"menuMaterialWhite"), style: .plain, target: self, action: nil)
        
        leftItem.rx.tap
            .subscribe(onNext: {
                ViewManager.sharedManager.openLeftSideMenu()
            })
            .disposed(by: disposeBag)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func openLeftMenu() {
        ViewManager.sharedManager.openLeftSideMenu()
    }
    
    func setupRightBarItem() {
        let rightItem = UIBarButtonItem(image: UIImage(named:"mailMaterialWhite"), style: .plain, target: self, action: nil)
        
        rightItem.rx.tap
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = rightItem
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
