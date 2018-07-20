//
//  EditProfileViewController.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/18.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EditProfileViewController: BaseViewController {
    
    let textFieldHeight: CGFloat = 35
    
    lazy var viewModel: EditProfileViewModel = {
        let viewModel = EditProfileViewModel()
        return viewModel
    }()
    
    lazy var contentStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [emailTextField, emailTextField, passwordTextField, confirmPasswordTextField, chStackView, enStackView, departmentTextField, professionalTitleTextField, telStackView, contactPhoneTextField])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 15.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "帳號E-mail"
        textfield.leftIconName = "mailMaterial"
        return textfield
    }()
    
    lazy var passwordTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "設定密碼"
        textfield.leftIconName = "lockMaterial"
        textfield.isSecureTextEntry = true
        return textfield
    }()

    lazy var confirmPasswordTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "確認密碼"
        textfield.leftIconName = "lockMaterial"
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    lazy var chStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [chFirstNameTextField, chLastNameTextField])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = UIStackViewDistribution.fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var chFirstNameTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "中文姓"
        textfield.leftIconName = "personMaterial"
        return textfield
    }()
    
    lazy var chLastNameTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "中文名"
        textfield.leftIconName = ""
        return textfield
    }()
    
    lazy var enStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [enFirstNameTextField, enLastNameTextField])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = UIStackViewDistribution.fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var enFirstNameTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "英文姓"
        textfield.leftIconName = "personMaterial"
        return textfield
    }()
    
    lazy var enLastNameTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "英文名"
        textfield.leftIconName = ""
        return textfield
    }()
    
    lazy var departmentTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "部門"
        textfield.leftIconName = "folderSharedMaterial"
        return textfield
    }()

    lazy var professionalTitleTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "職稱"
        textfield.leftIconName = "briefcaseFontAwesome"
        return textfield
    }()
    
    lazy var telStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [contactTelTextField, contactTelExtensionTextField])
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = UIStackViewDistribution.fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contactTelTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "聯絡電話"
        textfield.leftIconName = "phoneFontAwesome"
        return textfield
    }()
    
    lazy var contactTelExtensionTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "分機"
        textfield.leftIconName = ""
        return textfield
    }()

    lazy var contactPhoneTextField: InputTextField = {
        let textfield = InputTextField()
        textfield.snp.makeConstraints({ (make) in
            make.height.equalTo(textFieldHeight)
        })
        textfield.placeholder = "聯絡手機"
        textfield.leftIconName = "ionAndroidPhonePortraitIonicons"
        return textfield
    }()

    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.spaBrick
        button.setTitleColor(.white, for: .normal)
        button.setTitle("儲存", for: .normal)
        button.cornerRadius = 7
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

    func setupView() {
        view.addSubview(contentStackView)
        view.addSubview(saveButton)
        
        contentStackView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(42)
            make.top.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-42)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(contentStackView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            make.height.equalTo(35)
            make.width.equalTo(251)
            make.bottom.equalTo(self.view).offset(-71)
        }
    }
    
    func setupViewModel() {
        viewModel.updateLoadingStatus = { (status: Bool) -> Void in
            if status {
                ViewManager.sharedManager.showBusy(text: "載入中")
            }
            else {
                ViewManager.sharedManager.clearAllNotice()
            }
        }
        
        viewModel.reloadProfileData = { 
//            self?.viewModel.profileModel.email
        }
        
        viewModel.showMessage = { message in
            ViewManager.sharedManager.showAlert(message: message)
        }
        
        saveButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.savePressed()
            }.disposed(by: disposeBag)
        
        viewModel.loadData()
    }

}
