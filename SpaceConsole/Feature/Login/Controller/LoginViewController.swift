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
import RxCocoa

fileprivate let minimalPasswordLength = 5
fileprivate let maxmalPasswordLength = 20

class LoginViewController: BaseViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var accountErrorLabel: UILabel!
    
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        self.accountTextField.setUnderline()
        self.passwordTextField.setUnderline()
        self.loginButton.setCycleBorder()
        
        
        let usernameObservable = self.accountTextField.rx.text.orEmpty.asObservable()
            .distinctUntilChanged()
            
        usernameObservable
            .map {
                if $0.count == 0 {
                    return "請輸入Email"
                }
                else if !self.isValidEmail(email: $0) {
                    return "不是正確的Email格式"
                }
                else {
                    return ""
                }
            }
            .bind(to: accountErrorLabel.rx.text)
            .disposed(by: disposeBag)

        let usernameCheckMailValid =
            usernameObservable
                .map ({ (text: String) -> Bool in
                if text.count == 0 {
                    return false
                }
                else if !self.isValidEmail(email: text) {
                    return false
                }
                else {
                    return true
                }
            })
            .share(replay: 1)

        usernameCheckMailValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)

        
        let passwordValid = self.passwordTextField.rx.text.orEmpty
            .map { $0.count > minimalPasswordLength && $0.count < maxmalPasswordLength }
            .share(replay: 1)
            
        passwordValid
            .bind(to: passwordErrorLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        let combineValid = Observable.combineLatest(usernameCheckMailValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        combineValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .subscribe(onNext: {
                ViewManager.sharedManager.showBusy(text: "登入中...")
                DispatchQueue.global().async {
                    sleep(2)
                    DispatchQueue.main.async {
                        ViewManager.sharedManager.toMain()
                        ViewManager.sharedManager.clearAllNotice()
                    }
                }
            })
            .disposed(by: disposeBag)
        
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
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    @IBAction func ClickMe(_ sender: Any) {

    }
    
    
}
