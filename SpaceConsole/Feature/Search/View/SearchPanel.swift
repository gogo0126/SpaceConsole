//
//  SearchPanel.swift
//  SpaceConsole
//
//  Created by Jerry on 2018/7/12.
//  Copyright © 2018 SpaceAdvisor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchPanel: UIControl {
    
    let disposeBag = DisposeBag()

    lazy var keywordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "場地關鍵字"
        textfield.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        imgView.contentMode = .right
        imgView.image = UIImage(named: "searchMaterial")
        textfield.leftView = imgView
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()
    
    let pricePlanTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "計費方式"
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.contentMode = .left
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        textfield.rightView = imgView
        
        return textfield
    }()

    let postStatusTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "刊登狀態"
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.contentMode = .left
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        textfield.rightView = imgView
        
        return textfield
    }()

    lazy var sortMethodTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "排序方式"
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imgView.contentMode = .left
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        textfield.rightView = imgView
        textfield.inputView = sortPickerView
        textfield.delegate = self
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()
    
    lazy var doneToolBar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 44))
        toolbar.barStyle = .default
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        let flexSpaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpaceButton, doneButton]
        
        return toolbar
    }()
    
    let sortMethodSource = ["價格", "星等"]
    
    lazy var sortPickerView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(keywordTextfield)
        addSubview(pricePlanTextfield)
        addSubview(postStatusTextfield)
        addSubview(sortMethodTextfield)
        
        keywordTextfield.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        }
        
        pricePlanTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(postStatusTextfield)
        }
        
        postStatusTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(pricePlanTextfield.snp.right).offset(12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(sortMethodTextfield)
        }

        sortMethodTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(postStatusTextfield.snp.right).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(pricePlanTextfield)
        }

    }
    
    
}

extension SearchPanel: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortMethodSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sortMethodTextfield.text = self.sortMethodSource[row]
    }
}

extension SearchPanel: UITextFieldDelegate {
    @objc func doneButtonPressed() {
        self.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.sortMethodTextfield {
            
        }
    }
}
