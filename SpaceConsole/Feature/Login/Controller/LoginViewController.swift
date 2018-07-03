//
//  LoginViewController.swift
//  SpaceHR
//
//  Created by Jerry on 2018/6/6.
//  Copyright © 2018年 SpaceAdvisor. All rights reserved.
//

import UIKit
import SideMenu
import RxSwift

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "登入"
    
//        setupSideMenu()
        
//        setRightItemSearch()
//        setupLeftBarItem()

//        emailTextField.becomeFirstResponder()
        
//        ViewManager.sharedManager.pleaseWait()
//
//        ApiManager.sharedManager.fetchParks(offset: 0, limit: 10) {
//            (taipeiParkResponse: TaipeiApiResponse?, error: String?) in
//            ViewManager.sharedManager.clearAllNotice()
//            if let error = error {
////                print(error)
//                ViewManager.sharedManager.showError(text: error)
//            } else {
//                if let taipeiParkResponse = taipeiParkResponse {
//                    print(taipeiParkResponse)
//                }
//            }
//        }

        
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
    
        let leftMenuViewController = SideMenuViewController()
        SideMenuManager.default.menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenuViewController)
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar = false
        

        // Set up a cool background image for demo purposes
//        SideMenuManager.default.menuAnimationBackgroundColor = .blue
//            UIColor(patternImage: UIImage(named: "background")!)
    }

    
    
    @IBAction func ClickMe(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func dissMe() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
