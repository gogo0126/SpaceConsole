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
    var pickerViewDidShowedHandler: (() -> Void)?
    var placeSearchModel = PlaceSearchModel(keyword: "", pricePlan: 0, postStatus: 0, sortMethod: 0)
    var isPressDone: Bool = false
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return view
    }()

    lazy var keywordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "場地關鍵字"
        textfield.leftViewMode = .always
        textfield.font = UIFont.systemFont(ofSize: 10)
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        imgView.contentMode = .right
        imgView.image = UIImage(named: "searchMaterial")
        textfield.leftView = imgView
        textfield.delegate = self
        return textfield
    }()
    
    lazy var pricePlanTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "計費方式"
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 20))
        imgView.contentMode = .left
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        textfield.rightView = imgView
        textfield.inputView = pricePlanPickerView
        textfield.delegate = self
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()

    lazy var postStatusTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "刊登狀態"
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 20))
        imgView.contentMode = .left
        imgView.image = UIImage(named: "keyboardArrowDownMaterial")
        textfield.rightView = imgView
        textfield.inputView = postStatusPickerView
        textfield.delegate = self
        textfield.inputAccessoryView = doneToolBar
        return textfield
    }()

    lazy var sortMethodTextfield: UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.returnKeyType = .search
        textfield.placeholder = "排序方式"
        textfield.font = UIFont.systemFont(ofSize: 10)
        textfield.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 17, height: 20))
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
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed(item:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(item:)))
        let flexSpaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.items = [cancelButton, flexSpaceButton, doneButton]
        
        return toolbar
    }()
    
    let pricePlanSource = ["小時制", "時段制"]
    let postStatusSource = ["刊登中", "暫停刊登"]
    let sortMethodSource = ["依場地名稱", "依最後更新時間(新->舊)", "依最後更新時間(舊->新)", "依前台排序"]

    lazy var pricePlanPickerView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()

    lazy var postStatusPickerView: UIPickerView = {
        let pickView = UIPickerView()
        pickView.delegate = self
        pickView.dataSource = self
        return pickView
    }()

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
            make.left.equalTo(pricePlanTextfield.snp.right).offset(6)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(pricePlanTextfield)
        }

        sortMethodTextfield.snp.makeConstraints { (make) in
            make.left.equalTo(postStatusTextfield.snp.right).offset(6)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(keywordTextfield.snp.bottom).offset(12)
            make.width.equalTo(pricePlanTextfield.snp.width).offset(85)
        }
    }
    
    func searchText() {
        if placeSearchModel.keyword.isEmpty {
            return
        }
        
        
    }
    
}

extension SearchPanel: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == pricePlanPickerView) {
            return pricePlanSource.count
        }
        else if (pickerView == postStatusPickerView) {
            return postStatusSource.count
        }
        else {
            return sortMethodSource.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == pricePlanPickerView) {
            return pricePlanSource[row]
        }
        else if (pickerView == postStatusPickerView) {
            return postStatusSource[row]
        }
        else {
            return sortMethodSource[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView == pricePlanPickerView) {
//            pricePlanTextfield.text = pricePlanSource[row]
//        }
//        else if (pickerView == postStatusPickerView) {
//            postStatusTextfield.text = postStatusSource[row]
//        }
//        else {
//            sortMethodTextfield.text = sortMethodSource[row]
//        }
    }
}

extension SearchPanel {
    @objc func cancelButtonPressed(item: UIBarButtonItem) {
        isPressDone = false
        self.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.blackView.removeFromSuperview()
        }
    }
    
    @objc func doneButtonPressed(item: UIBarButtonItem) {
        isPressDone = true
        self.endEditing(true)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.blackView.removeFromSuperview()
        }

    }
}

extension SearchPanel: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == keywordTextfield {
            return true
        }
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelButtonPressed(item:))))

            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !isPressDone || textField == keywordTextfield {
            return
        }
        
        if (textField == pricePlanTextfield) {
            let index = pricePlanPickerView.selectedRow(inComponent: 0)
            placeSearchModel.pricePlan = index
            pricePlanTextfield.text = pricePlanSource[index]
        }
        else if (textField == postStatusTextfield) {
            let index = postStatusPickerView.selectedRow(inComponent: 0)
            placeSearchModel.postStatus = index
            postStatusTextfield.text = postStatusSource[index]
        }
        else if (textField == sortMethodTextfield) {
            let index = sortPickerView.selectedRow(inComponent: 0)
            placeSearchModel.sortMethod = index
            sortMethodTextfield.text = sortMethodSource[index]
        }
        
        searchText()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField != keywordTextfield {
            return false
        }

        textField.resignFirstResponder()
        placeSearchModel.keyword = textField.text!
        searchText()

        return true
    }
}

struct PlaceSearchModel {
    var keyword: String
    var pricePlan: Int
    var postStatus: Int
    var sortMethod: Int
}
