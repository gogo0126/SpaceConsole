//
//  SPAViewManager.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/6/7.
//  Copyright © 2018年 SpaceAdvisor. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD
import SideMenu

class ViewManager: UIViewController {

    static let sharedManager = ViewManager()
    var myRootViewController: UIViewController?
    var popupController: PopupController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftMenuViewController = SideMenuViewController()
        leftMenuViewController.view.snp.makeConstraints { (make) in
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
        }
        
        self.popupController = PopupController(popupView: leftMenuViewController.view, with: .fromLeft)
        
    }

    func setRootViewController(_ newRootViewController: UIViewController) {
        //移除舊的畫面
        if self.myRootViewController != nil && !(self.myRootViewController == newRootViewController) {
//            var oldVC: UIViewController? = self.myRootViewController
            let orView: UIView? = self.myRootViewController!.view
            let transform: CATransform3D = CATransform3DTranslate(CATransform3DIdentity, 0, -UIScreen.main.bounds.height, 0)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
                orView?.layer.transform = transform
            }) { finished in
                orView?.layer.transform = CATransform3DIdentity
                orView?.removeFromSuperview()
//                oldVC = nil
            }
        }
        self.myRootViewController = newRootViewController
        view.insertSubview(self.myRootViewController!.view, at: 0)
        self.myRootViewController!.view.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
    }
}

// 切換navigation
extension ViewManager {
    
    func toLogin() {
        let nc = LoginNavigationController.defaultNavigation
//        nc.setNavigationBarHidden(true, animated: false)
        ViewManager.sharedManager.setRootViewController(nc)
    }
    
    func toMain() {
        let nc = MainNavigationController.defaultNavigation
        ViewManager.sharedManager.setRootViewController(nc)
    }


}


// 切換側邊欄
extension ViewManager {
    func openLeftSideMenu() {
        if let popupController = self.popupController {
            popupController.animation = .fromLeft
            popupController.popupOnView(view: self.view, with: .leftMenu)
        }
    }
    
    @objc func closeLeftSideMenu() {
        self.popupController!.dismiss()
    }
}


// 跳出警告
extension ViewManager {
    //秀確認畫面
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
            let confirmAction = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(confirmAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}


// 顯示忙錄圖
extension ViewManager {
    func setupHUD() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    }
    
    //秀忙碌圖
    func pleaseWait() {
        setupHUD()
        SVProgressHUD.show()
    }
    
    //清除忙碌圖
    func clearAllNotice() {
        SVProgressHUD.dismiss()
    }
    
    //秀忙碌圖加文字
    func showBusy(text: String!) {
        setupHUD()
        SVProgressHUD.show(withStatus: text)
    }
    
    //秀成功文字
    func showSuccess(text: String!) {
        setupHUD()
        SVProgressHUD.showSuccess(withStatus: text)
    }
    
    //秀錯誤文字
    func showError(text: String!) {
        setupHUD()
        SVProgressHUD.showError(withStatus: text)
    }
    
    //秀資訊文字
    func showInfo(text: String!) {
        setupHUD()
        SVProgressHUD.showInfo(withStatus: text)
    }
}

