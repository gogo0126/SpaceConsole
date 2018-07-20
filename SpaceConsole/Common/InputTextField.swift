//
//  InputTextField.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/19.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit

class InputTextField: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var leftIconName: String = "" {
        didSet {
            self.leftIconImageView.image = UIImage(named: leftIconName)
            self.leftIconImageView.snp.updateConstraints { (make) in
                if !leftIconName.isEmpty {
                    make.width.height.equalTo(18)
                }
                else {
                    make.width.height.equalTo(0)
                }
            }
        }
    }
    
    private lazy var leftIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var text: String {
        get {
            return textField.text!
        }
        
        set {
            textField.text = text
        }
    }
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    private lazy var textField: FloatLabelTextField = {
        let textfield = FloatLabelTextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .continue
        textfield.titleActiveTextColour = UIColor.black
        textfield.titleTextColour = UIColor.black
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.setUnderline()
        return textfield
    }()
    
    private func setupView() {
        addSubview(leftIconImageView)
        addSubview(textField)
        
        leftIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(18)
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(leftIconImageView.snp.right).offset(6)
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(35)
        }
    }
    
}
